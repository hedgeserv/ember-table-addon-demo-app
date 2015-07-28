import re


class GroupMetadata:
    def __init__(self, zipped_row):
        self.levels = []
        self.parse_meta_str(zipped_row["groupName"])

        self.column_value_prefixes = zipped_row.copy()
        self.column_value_prefixes.pop("groupName")

    def make_group_rows(self):
        first_group_level = self.get_group_level(0)
        normal_order_rows = first_group_level.expand_this_level(VirtualTopRow(), None)
        asc_rows = first_group_level.expand_this_level(VirtualTopRow(), 'asc')
        desc_rows = first_group_level.expand_this_level(VirtualTopRow(), 'desc')
        return normal_order_rows + asc_rows + desc_rows

    def parse_meta_str(self, pattern_str):
        levels = pattern_str.split('-')
        for l in levels:
            search = re.search('(.+?)\[(\d+)\]', l)
            level_name = search.group(1)
            element_count = int(search.group(2))
            self.levels.append((level_name, element_count))

    def get_group_names(self):
        return [level[0] for level in self.levels]

    def get_group_level(self, level_index):
        level = self.levels[level_index]
        if level_index == len(self.levels) - 1:
            return LastGroupLevel(level[0], level[1], self, level_index)
        return GroupLevel(level[0], level[1], self, level_index)

    def get_column_value_prefixes(self):
        return self.column_value_prefixes


class GroupLevel:
    def __init__(self, level_name, element_count, group_metadata, level_index):
        self.level_name = level_name
        self.element_count = element_count
        self.group_metadata = group_metadata
        self.level_index = level_index

    def expand_this_level(self, parent_row, sort_direction=None):
        result = []
        id_range = self.make_id_range(sort_direction)
        rows = [GroupRow(self, parent_row, x) for x in id_range]
        query = parent_row.get_query()
        if sort_direction == 'asc':
            query.update({'sortNames[0]': 'id', 'sortDirects[0]': 'asc'})
        elif sort_direction == 'desc':
            query.update({'sortNames[0]': 'id', 'sortDirects[0]': 'desc'})
        rows_values = [row.make_row_values() for row in rows]
        result.append({"query": query, "body": rows_values})

        children_results = self.expand_next_level(rows, sort_direction)
        result = sum(children_results, result)
        return result

    def expand_next_level(self, rows, sort_direction):
        next_group_level = self.next_group_level()
        return [next_group_level.expand_this_level(row, sort_direction) for row in rows]

    def make_id_range(self, sort_direction=None):
        id_range = [str(x) for x in range(1, self.element_count + 1)]
        return id_range

    def next_group_level(self):
        return self.group_metadata.get_group_level(self.level_index + 1)

    def get_query(self, group_name):
        return {self.level_name: self.group_metadata.get_column_value_prefixes()["id"] + group_name}

    def make_column_values(self, group_name):
        prefixes = self.group_metadata.get_column_value_prefixes()
        result = {}
        for key in prefixes:
            result[key] = prefixes[key] + group_name
        result[self.level_name] = result["id"]
        return result


class LastGroupLevel(GroupLevel):
    def expand_next_level(self, rows, sort_direction):
        return []

    def make_id_range(self, sort_direction=None):
        id_range = [str(x) for x in range(1, self.element_count + 1)]
        if sort_direction == 'desc':
            id_range.sort(reverse=True)
        elif sort_direction == 'asc':
            id_range.sort()
        return id_range

    def next_group_level(self):
        return None

    def get_query(self, group_name):
        return {}


class GroupRow:
    def __init__(self, group_level, parent_row, index):
        self.index = index
        self.group_level = group_level
        self.parent_row = parent_row

    def get_group_name(self):
        return self.parent_row.concat_child_group_name(str(self.index))

    def concat_child_group_name(self, child_name):
        return self.get_group_name() + "-" + child_name

    def get_query(self):
        result = {}
        result.update(self.group_level.get_query(self.get_group_name()))
        result.update(self.parent_row.get_query())

        return result

    def make_row_values(self):
        result = self.group_level.make_column_values(self.get_group_name())
        result.update(self.get_query())
        return result


class VirtualTopRow(GroupRow):
    def __init__(self):
        GroupRow.__init__(self, None, None, None)

    def concat_child_group_name(self, child_name):
        return child_name

    def get_query(self):
        return {}

    def make_row_values(self):
        return {}
