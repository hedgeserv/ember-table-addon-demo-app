import requests
import json


class MountebankStub:
    def __init__(self):
        self.mb_url = 'http://localhost:2525/imposters/'

    def create_imposter(self, stubs):
        stub_port = 8888
        requests.delete(self.mb_url + str(stub_port))
        params = {
            "port": stub_port,
            "protocol": "http",
            "name": "test",
            "stubs": stubs
        }
        requests.post(self.mb_url, data=json.dumps(params))

    def stub_loans(self, count, path="/loans"):
        loans = generate_loans(count)
        stubs = [make_the_stub(loans, path=path)]
        self.create_imposter(stubs)

    def stub_loans_in_chunk(self, total_count, chunk_size, path="/loans"):
        loans = generate_loans(total_count)
        stubs = make_the_chunk_stubs(loans, chunk_size, path=path)
        self.create_imposter(stubs)

    def stub_loans_in_chunk_and_sortable(self, total_count, chunk_size, path="/loans"):
        loans_in_asc = generate_loans(total_count)
        loans_in_asc.sort(key=lambda x: int(x['id']))
        asc_stubs = make_the_chunk_stubs(loans_in_asc, chunk_size,
                                         query={'sortName': 'id', 'sortDirect': 'asc'}, path=path)

        loans_in_desc = generate_loans(total_count)
        loans_in_desc.sort(reverse=True, key=lambda x: int(x['id']))
        desc_stubs = make_the_chunk_stubs(loans_in_desc, chunk_size,
                                          query={'sortName': 'id', 'sortDirect': 'desc'}, path=path)

        default_loans = generate_loans(total_count)
        default_stubs = make_the_chunk_stubs(default_loans, chunk_size, path=path)

        stubs = []
        stubs.extend(asc_stubs)
        stubs.extend(desc_stubs)
        stubs.extend(default_stubs)
        self.create_imposter(stubs)

    def stub_grouped_loans_by_count(self, count):
        loans = generate_grouped_loans(int(count))
        stubs = [make_the_stub(loans, query={"group": 'true'})]
        self.create_imposter(stubs)

    def stub_grouped_loans(self, data):
        loans = []
        for item in data:
            loan = {}
            for key in item:
                loan[key] = item[key]

            path = loan['groupName'].split('-')
            if len(path) == 1:
                loans.append(loan)
            else:
                parent_loan = self.find_parent(loans, path)
                if not parent_loan.has_key('children'):
                    parent_loan['children'] = []
                parent_loan['children'].append(loan)

        stubs = [make_the_stub(loans, query={"group": 'true'})]
        self.create_imposter(stubs)

    def find_parent(self, loans, path):
        loan = self.find_by_group_name(loans, path[0:1])
        for depth in range(2, len(path)):
            loan = self.find_by_group_name(loan['children'], path[0:depth])
        return loan

    def find_by_group_name(self, loans, path):
        group_name = '-'.join(path)
        return filter(lambda x: x['groupName'] == group_name, loans)[0]


def generate_loans(count):
    return [{"id": i, "activity": "activity-" + str(i), "status": "status" + str(i)} for i in range(count)]


def generate_grouped_loans(count):
    loans = generate_loans(int(count))
    for index, loan in enumerate(loans):
        loan['isGroupRow'] = True
        loan['groupName'] = 'Group ' + str(index)
    return loans


def make_response(loans):
    return {
        "is": {
            "headers": {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"
            },

            "body": json.dumps({
                "header": {"page": 1},
                "loans": loans
            })
        }
    }


def make_the_predicate(query=None, path="/loans"):
    predicate = {
        "equals": {
            "method": "GET",
            "path": path
        }
    }
    if query and len(query):
        predicate["equals"].update({"query": query})

    return predicate


def make_the_stub(loans, query=None, path="/loans"):
    response = make_response(loans)
    predicate = make_the_predicate(query, path)
    return {
        "responses": [response],
        "predicates": [predicate]
    }


def make_the_chunk_stubs(all_loans, chunk_size=100, query=None, path="/loans"):
    total = len(all_loans)
    chunks = [all_loans[i:i + chunk_size] for i in range(0, total, chunk_size)]
    stubs = [make_the_stub(c, merge_query(query, {"section": str(i + 1)}), path) for i, c in enumerate(chunks)]
    return stubs


def merge_query(query, more):
    if query:
        result = query.copy()
    else:
        result = {}
    result.update(more)
    return result


def prepare_loans(count):
    mb = MountebankStub()
    mb.stub_loans(count)


def prepare_loans_in_chunk(total, chunk_size=100):
    mb = MountebankStub()
    mb.stub_loans_in_chunk(total, chunk_size)


def prepare_sort_in_chunk(total, chunk_size=100):
    mb = MountebankStub()
    mb.stub_loans_in_chunk_and_sortable(total, chunk_size)


def prepare_grouping_data(count):
    mb = MountebankStub()
    mb.stub_grouped_loans_by_count(count)


def prepare_grouped_loans(data):
    mb = MountebankStub()
    mb.stub_grouped_loans(data)
