import re
from sort_criteria import SortCriteria

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
            level_name, id_range = self.analysis_value(l)
            self.levels.append((level_name, id_range))

    def get_group_names(self):
        return [level[0] for level in self.levels]

    def get_group_level(self, level_index):
        level = self.levels[level_index]
        if level_index == len(self.levels) - 1:
            return LastGroupLevel(level[0], level[1], self, level_index)
        return GroupLevel(level[0], level[1], self, level_index)

    def get_column_value_prefixes(self):
        return self.column_value_prefixes

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
        return [next_group_level.expand_this_level(row, sort_direction) for row in rows]

    def make_id_range(self, sort_direction=None):
        return self.id_range

    def next_group_level(self):
        return self.group_metadata.get_group_level(self.level_index + 1)

    def get_query(self, group_name):
        id_key = self.group_metadata.get_column_value_prefixes()["id"]
        return {self.level_name:  self.handle_prefixes(id_key, 0)[0]+ group_name}

    def make_column_values(self, path, index=None):
        prefixes = self.group_metadata.get_column_value_prefixes()
        path = path + '-' if path else ''
        result = {}
        for key in prefixes:
            prev_key, value = self.handle_prefixes(prefixes[key], index)
            result[key] = prev_key + path + str(value)
        result[self.level_name] = result["id"]
        return result

    def handle_prefixes(self, key, index):
        res = re.search('\[(.*?)\]', key)
        name = key.replace(res.group(0), '') if res else key
        return  name, index

class LastGroupLevel(GroupLevel):

    def column_names(self):
        return self.group_metadata.column_value_prefixes.keys()

    def expand_this_level(self, parent_row, sort_direction=None):
        result = []
        id_range = self.make_id_range(sort_direction)
        rows = [GroupRow(self, parent_row, index) for index, x in enumerate(id_range)]
        query = parent_row.get_query()
        rows_values = [row.make_row_values() for row in rows]
        result.append({"query": query, "body": rows_values})
        children_results = self.expand_next_level(rows, sort_direction)
        result = sum(children_results, result)
        sortColumns = ["id", "beginningDr", "beginningCr"]
        provider = SortConditionProvider(list(set(sortColumns) & set(self.column_names())))
        for sort_criteria in provider.all():
            localQuery = query.copy()
            data = sort_criteria.sort(rows_values[:])
            localQuery.update(sort_criteria.to_query())
            result.append({"query": localQuery, "body": data})
            result = sum(children_results, result)
        return result


    def expand_next_level(self, rows, sort_direction):
        return []

    def make_id_range(self, sort_direction=None):
        id_range = self.id_range[:]
        if sort_direction == 'desc':
            id_range.sort(reverse=True)
        elif sort_direction == 'asc':
            id_range.sort()
        return id_range

    def handle_prefixes(self, key, index):
        res = re.search('\[(.*?)\]', key)
        if(res):
            val = res.group(1)
            values = range(1, int(val) + 1) if val.isalnum() else [int(i) for i in val.split(',')]
            return  key.replace(res.group(0), ''), values[index - 1]
        else:
            return key, index

    def next_group_level(self):
        return None

    def get_query(self, group_name):
        return {}


class GroupRow:
    def __init__(self, group_level, parent_row, index):
        self.index = index + 1 if isinstance(index, int) else None
        self.group_level = group_level
        self.parent_row = parent_row

    def get_query(self):
        result = {}
        result.update(self.group_level.get_query(self.get_path()))
        result.update(self.parent_row.get_query())

        return result

    def get_path(self):
        parent_path = self.parent_row.get_path()
        path = parent_path + '-' + str(self.index) if parent_path else str(self.index)
        return path

    def make_row_values(self):
        result = self.group_level.make_column_values(self.parent_row.get_path(), self.index)
        result.update(self.get_query())
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
        return ''


class SortConditionProvider:

    def __init__(self, columns):
        self.columns = list(columns)

    def product_names(self):
        items = []
        for i in range(len(self.columns)):
            items = items + self.product(items, self.columns, True)

        return self.uniq(items)

    def add_directs(self, names):

        sort_directs = ['asc', 'desc']
        all_directs = []
        sortConditions = []
        for i in range(len(names)):
            all_directs = self.product(all_directs, sort_directs)
        for directs in all_directs:
            sortCondition = [{"sortName": names[idx], "sortDirect": direct} for idx, direct in enumerate(directs)]
            sortConditions.append(sortCondition)
        return sortConditions

    def product(self, first_arr, second_arr, uniq=False):
        if(not first_arr):
            return [[i] for i in second_arr]
        result = []
        for first in first_arr:
            for second in second_arr:
                item = first[:]
                if(not uniq or not second in item):
                    item.append(second)
                    result.append(item)
        return result

    def uniq(self, arr):
        result = []
        for item in arr:
            if(not item in result):
                result.append(item)
        return result

    def all(self):
        conditions = []
        names_arr = self.product_names()
        for names in names_arr:
            conditions += self.add_directs(names)
        return [SortCriteria(condition) for condition in conditions];