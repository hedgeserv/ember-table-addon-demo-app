import requests
import json


class MountebankStub:
    def __init__(self):
        self.mb_url = 'http://localhost:2525/imposters/'

    def delete_imposter(self, port=8888):
        requests.delete(self.mb_url + str(port))

    def create_imposter(self, stubs):
        params = {
            "port": 8888,
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


def make_predicate(page_index):
    predicate = {
        "equals": {
            "method": "GET",
            "path": "/loans",
            "query": {
                "page": str(page_index)
            }
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


def make_chunk_stubs(total):
    all_loans = generate_loans(total)
    chunk_size = 100
    chunks = [all_loans[i:i + chunk_size] for i in range(0, len(all_loans), chunk_size)]
    stubs = [make_stub(c, make_predicate(i + 1)) for i, c in enumerate(chunks)]
    return stubs


def _prepare(count, stub_maker=make_stubs):
    mb = MountebankStub()
    mb.delete_imposter()

    stubs = stub_maker(count)

    mb.create_imposter(stubs)


def prepare_loans(count):
    _prepare(count)


def prepare_loans_in_chunk(total):
    _prepare(total, make_chunk_stubs)