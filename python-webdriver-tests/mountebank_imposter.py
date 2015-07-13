import json


class Response:
    def __init__(self, data, content_key, meta=None):
        self.data = data
        self.content_key = content_key
        self.meta = meta
        if not self.meta:
            self.meta = {}

    def set_meta(self, meta):
        self.meta = meta

    def to_mountebank(self):
        return {
            "is": {
                "headers": {
                    "Content-Type": "application/json",
                    "Access-Control-Allow-Origin": "*"
                },

                "body": json.dumps({
                    "meta": self.meta,
                    self.content_key: self.data
                })
            }
        }


class Predicate:
    def __init__(self, path, query=None):
        self.path = path
        self.query = query

    def merge_query(self, parameter_value_dict):
        if self.query:
            query = self.query.copy()
        else:
            query = {}
        query.update(parameter_value_dict)
        return Predicate(self.path, query)

    def to_mountebank(self):
        predicate = {
            "deepEquals": {
                "method": "GET",
                "path": self.path
            }
        }
        if self.query and len(self.query):
            predicate["deepEquals"].update({"query": self.query})

        return predicate


class ChunkMeta:
    def __init__(self, total, chunk_index, chunk_size):
        self.total = total
        self.chunk_index = chunk_index
        self.chunk_size = chunk_size

    def meta_dict(self):
        return {"total": self.total, "page_size": self.chunk_size, "page": self.chunk_index + 1}

    def chunk_query(self):
        return {"section": str(self.chunk_index + 1)}


class Stub:
    def __init__(self, response, predicate):
        self.response = response
        self.predicate = predicate

    def to_mountebank(self):
        return {
            "responses": [self.response.to_mountebank()],
            "predicates": [self.predicate.to_mountebank()]
        }


class StubFactory:
    def __init__(self):
        pass

    @staticmethod
    def make_loans_stub(loans, path):
        response = Response(loans, "loans")
        predicate = Predicate(path)
        return Stub(response, predicate).to_mountebank()

    @staticmethod
    def make_group_loans_stub(loans):
        response = Response(loans, "loans")
        predicate = Predicate("/loans", {"group": "true"})
        return Stub(response, predicate).to_mountebank()

    @staticmethod
    def make_chunk_stubs(data, content_key, chunk_size, predicate):
        stubs = []
        total = len(data)
        chunk_index = 0
        for i in range(0, total, chunk_size):
            chunk_data = data[i:i + chunk_size]
            chunk_meta = ChunkMeta(total, chunk_index, chunk_size)
            chunk_response = Response(chunk_data, content_key, chunk_meta.meta_dict())
            new_predicate = predicate.merge_query(chunk_meta.chunk_query())
            chunk_stub = Stub(chunk_response, new_predicate).to_mountebank()
            stubs.append(chunk_stub)
            chunk_index += 1
        return stubs

    @staticmethod
    def make_chunk_loan_stubs(data, chunk_size, predicate):
        return StubFactory.make_chunk_stubs(data, "loans", chunk_size, predicate)

    @staticmethod
    def make_chunk_group_stubs(data, chunk_size, predicate):
        return StubFactory.make_chunk_stubs(data, "chunkedGroups", chunk_size, predicate)
