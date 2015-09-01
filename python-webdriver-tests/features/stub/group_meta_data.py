import re

class GroupMetadata:
    def __init__(self, zipped_row):
        self.levels = []
        self.column_values = zipped_row.copy()
        self.parse_meta_str(self.column_values.pop("groupName"))

    def make_group_rows(self):
        first_group_level = self.get_group_level(0)
        return first_group_level.expand_this_level(VirtualTopRow(), None)

    def parse_meta_str(self, pattern_str):
        levels = pattern_str.split('-')
        for l in levels:
            level_name, id_range = self.analysis_value(l)
            self.levels.append((level_name, id_range))

    def get_group_names(self):
        return [level[0] for level in self.levels]

    def get_group_level(self, level_index):
        if level_index == len(self.levels):
            return None
        level = self.levels[level_index]
        return GroupLevel(level[0], level[1], self, level_index)

    def get_column_values(self):
        return self.column_values

    def analysis_value(self, value):
        search = re.search('(.+?)\[([\d|,]+)\]', value)
        level_name = search.group(1)
        val = search.group(2)
        values = range(1, int(val) + 1) if val.isalnum() else [int(i) for i in val.split(',')]
        return level_name, values

class GroupLevel:
    def __init__(self, level_name, id_range, group_metadata, level_index):
        self.level_name = level_name
        self.id_range = id_range
        self.group_metadata = group_metadata
        self.level_index = level_index

    def expand_this_level(self, parent_row, sort_direction=None):
        result = []
        id_range = self.make_id_range(sort_direction)
        rows = [GroupRow(self, parent_row, index) for index, x in enumerate(id_range)]
        query = parent_row.get_query()
        rows_values = [row.make_row_values() for row in rows]
        result.append({"query": query, "body": rows_values})
        children_results = self.expand_next_level(rows, sort_direction)
        result = sum(children_results, result)
        return result

    def expand_next_level(self, rows, sort_direction):
        next_group_level = self.next_group_level()
        if next_group_level:
            return [next_group_level.expand_this_level(row, sort_direction) for row in rows]
        else:
            return []

    def make_id_range(self, sort_direction=None):
        return self.id_range

    def next_group_level(self):
        return self.group_metadata.get_group_level(self.level_index + 1)

    def get_query(self, group_name):
        return {self.level_name:  group_name}

    def make_column_values(self, path, index=None):
        prefixes = self.group_metadata.get_column_values()
        result = {}
        for key in prefixes:
            prefix = self.get_prefix(prefixes[key])
            value = self.handle_prefixes(prefixes[key], index)
            local_path = path[:]
            local_path.append(value)
            if(prefix):
                result[key] = prefix + '-'.join([str(i) for i in local_path])
            else:
                result[key] = reduce(lambda res, i: res*100 + i, local_path, 0)

        result[self.level_name] = result["id"]
        return result

    def is_last_level(self):
        return len(self.group_metadata.levels) == self.level_index + 1

    def get_prefix(self, value):
        search = re.match('^(.*?)(\[|$)', value)
        return search.group(1) if search else None

    def handle_prefixes(self, key, index):
        res = re.search('\[(.*?)\]', key)
        if(res and self.is_last_level()):
            val = res.group(1)
            values = range(1, int(val) + 1) if val.isalnum() else [int(i) for i in val.split(',')]
            return values[index - 1]
        else:
            return index

class GroupRow:
    def __init__(self, group_level, parent_row, index):
        self.index = index + 1
        self.group_level = group_level
        self.parent_row = parent_row

    def get_query(self):
        result = {}
        value = reduce(lambda res, i: res * 100 + i, self.get_path(), 0)
        result.update(self.group_level.get_query(value))
        result.update(self.parent_row.get_query())
        return result

    def get_path(self):
        path = self.parent_row.get_path()
        path.append(self.index)
        return path

    def make_row_values(self):
        result = self.get_query()
        value = self.group_level.make_column_values(self.parent_row.get_path(), self.index)
        result.update(value)
        return result


class VirtualTopRow(GroupRow):
    def __init__(self):
        "mock group row"

    def concat_child_group_name(self, child_name):
        return child_name

    def get_query(self):
        return {}

    def make_row_values(self):
        return {}

    def get_path(self):
        return []
