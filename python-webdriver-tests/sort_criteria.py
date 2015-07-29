import operator

class SortCriteria:
    def __init__(self, content=[]):
        self.content = content

    def append_criteria(self, name, direction):
        return SortCriteria(self.content + [{'sortName': name, 'sortDirect': direction}])

    def sort(self, data):
        sorted_data = data
        for s in list(reversed(self.content)):
            is_reverse = s['sortDirect'] == 'desc'
            sorted_data = sorted(sorted_data, key=operator.itemgetter(s['sortName']), reverse=is_reverse)
        return sorted_data

    def to_query(self):
        index = 0
        query = {}
        for item in self.content:
            name_key = 'sortNames[' + str(index) + ']'
            direct_key = 'sortDirects[' + str(index) + ']'
            query[name_key] = item['sortName']
            query[direct_key] = item['sortDirect']
            index += 1

        return query