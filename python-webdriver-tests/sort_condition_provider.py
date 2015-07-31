from sort_criteria import SortCriteria

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