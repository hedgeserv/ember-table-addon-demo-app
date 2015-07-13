import requests
import json
from group_meta_data import GroupMetadata
from mountebank_imposter import StubFactory, Predicate


class MountebankServer:
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


def create_imposter(stubs):
    MountebankServer().create_imposter(stubs)


def stub_loans(count, path="/loans"):
    loans = generate_loans(count)
    stubs = [StubFactory.make_loans_stub(loans, path)]
    return stubs


def stub_loans_in_chunk(total_count, chunk_size, path="/loans"):
    loans = generate_loans(total_count)
    stubs = StubFactory.make_chunk_loan_stubs(loans, chunk_size, Predicate(path))
    return stubs


def stub_loans_in_chunk_and_sortable(total_count, chunk_size, path="/loans"):
    loans_in_asc = generate_loans(total_count)
    loans_in_asc.sort(key=lambda x: int(x['id']))
    asc_stubs = StubFactory.make_chunk_loan_stubs(loans_in_asc, chunk_size,
                                                  Predicate(path, {'sortNames[0]': 'id', 'sortDirects[0]': 'asc'}))

    loans_in_desc = generate_loans(total_count)
    loans_in_desc.sort(reverse=True, key=lambda x: int(x['id']))
    desc_stubs = StubFactory.make_chunk_loan_stubs(loans_in_desc, chunk_size,
                                                   Predicate(path, {'sortNames[0]': 'id', 'sortDirects[0]': 'desc'}))

    default_loans = generate_loans(total_count)
    default_stubs = StubFactory.make_chunk_loan_stubs(default_loans, chunk_size, Predicate(path))

    stubs = []
    stubs.extend(asc_stubs)
    stubs.extend(desc_stubs)
    stubs.extend(default_stubs)
    return stubs


def stub_grouped_loans_by_count(count):
    loans = generate_grouped_loans(int(count))
    stubs = [StubFactory.make_group_loans_stub(loans)]
    return stubs


def stub_grouped_loans(data):
    loans = []
    for item in data:
        loan = {}
        for key in item:
            loan[key] = item[key]

        path = loan['groupName'].split('-')
        if len(path) == 1:
            loans.append(loan)
        else:
            parent_loan = find_parent(loans, path)
            if not ('children' in parent_loan):
                parent_loan['children'] = []
            parent_loan['children'].append(loan)

    stubs = [StubFactory.make_group_loans_stub(loans)]
    return stubs


def stub_grand_total_row():
    rows = [{"id": "1"}]
    stubs = StubFactory.make_chunk_group_stubs(rows, 1, Predicate("/chunkedGroups"))
    return stubs


def stub_lazy_loaded_grouped_loans(array_of_query_and_body, group_level_names):
    stubs = []
    for item in array_of_query_and_body:
        path = "/chunkedGroups"
        query = item['query']
        for group_level_name in group_level_names:
            path += '/' + group_level_name + 's'
            if group_level_name in query:
                path += '/' + str(query[group_level_name])
                del query[group_level_name]
            else:
                break
        stubs.extend(StubFactory.make_chunk_group_stubs(item["body"], 10, Predicate(path, query)))
    return stubs


def find_parent(loans, path):
    loan = find_by_group_name(loans, path[0:1])
    for depth in range(2, len(path)):
        loan = find_by_group_name(loan['children'], path[0:depth])
    return loan


def find_by_group_name(loans, path):
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


def prepare_loans(count):
    create_imposter(stub_loans(count))


def prepare_loans_in_chunk(total, chunk_size=100):
    create_imposter(stub_loans_in_chunk(total, chunk_size))


def prepare_sort_in_chunk(total, chunk_size=100):
    create_imposter(stub_loans_in_chunk_and_sortable(total, chunk_size))


def prepare_grouping_data(count):
    create_imposter(stub_grouped_loans_by_count(count))


def prepare_grouped_loans(data):
    create_imposter(stub_grouped_loans(data))


def prepare_lazy_loaded_grouped_loans(zipped_rows):
    zipped_row = zipped_rows[0]
    group_metadata = GroupMetadata(zipped_row)
    group_names = group_metadata.get_group_names()
    array_of_url_and_body = group_metadata.make_group_rows()
    create_imposter(stub_lazy_loaded_grouped_loans(array_of_url_and_body, group_names))


def prepare_grand_total_row():
    create_imposter(stub_grand_total_row())
