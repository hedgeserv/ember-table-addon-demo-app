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


def generate_loans(count):
    return [{"id": i, "activity": "activity-" + str(i), "status": "status" + str(i)} for i in range(count)]


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


def make_predicate(page_index, query={}):
    current_query = query.copy()
    current_query.update({
        "section": str(page_index)
    })
    predicate = {
        "equals": {
            "method": "GET",
            "path": "/loans",
            "query": current_query
        }
    }
    return predicate


def make_stub(loans, predicate):
    response = make_response(loans)
    return {
        "responses": [response],
        "predicates": [predicate]
    }


def make_stubs(count):
    loans = generate_loans(count)
    return [
        make_stub(loans, {
            "equals": {
                "method": "GET",
                "path": "/loans",
            }
        })
    ]


def make_chunk_stubs(total, chunk_size=100):
    all_loans = generate_loans(total)
    chunks = [all_loans[i:i + chunk_size] for i in range(0, len(all_loans), chunk_size)]
    stubs = [make_stub(c, make_predicate(i + 1)) for i, c in enumerate(chunks)]
    return stubs


def _prepare(count, chunk_size, stub_maker=make_stubs):
    mb = MountebankStub()

    stubs = stub_maker(count, chunk_size)

    mb.create_imposter(stubs)


def prepare_loans(count):
    mb = MountebankStub()

    stubs = make_stubs(count)

    mb.create_imposter(stubs)


def prepare_loans_in_chunk(total, chunk_size=100):
    _prepare(total, chunk_size, make_chunk_stubs)


def prepare_asc_stubs_in_chunk(total, chunk_size):
    all_loans = sorted(generate_loans(total))
    all_loans.sort(key=lambda x: int(x['id']))
    chunks = [all_loans[i:i + chunk_size] for i in range(0, len(all_loans), chunk_size)]
    return [make_stub(c, make_predicate(i + 1, {'sortName': 'id', 'sortDirect': 'asc'})) for i, c in enumerate(chunks)]

def prepare_desc_stubs_in_chunk(total, chunk_size):
    all_loans = generate_loans(total)
    all_loans.sort(reverse=True, key=lambda x: int(x['id']))
    chunks = [all_loans[i:i + chunk_size] for i in range(0, len(all_loans), chunk_size)]
    return [make_stub(c, make_predicate(i + 1, {'sortName': 'id', 'sortDirect': 'desc'})) for i, c in enumerate(chunks)]



def prepare_sort_in_chunk(total, chunk_size=100):
    mb = MountebankStub()
    stubs = []
    asc_stubs = prepare_asc_stubs_in_chunk(total, chunk_size)
    desc_stubs = prepare_desc_stubs_in_chunk(total, chunk_size)
    default_stubs = make_chunk_stubs(total, chunk_size)
    stubs.extend(asc_stubs)
    stubs.extend(desc_stubs)
    stubs.extend(default_stubs)

    mb.create_imposter(stubs)
