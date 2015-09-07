import json
import os

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
        path = os.getcwd() + "/mountebank-server"
        injection = open(path + "/sort-behaviors.js").read()
        return {
            "is": {
                "headers": {
                    "Content-Type": "application/json",
                    "Access-Control-Allow-Origin": "*",
                    "_hidden": {
                        "dirName": path,
                        "sortNameMap": {}
                    }
                },

                "body": json.dumps({
                    "meta": self.meta,
                    self.content_key: self.data
                })
            },
            "_behaviors": {
                "decorate": injection
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
        return {"total": self.total, "pageSize": self.chunk_size, "page": self.chunk_index + 1}

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
    def make_group_loans_stub(loans):
        response = Response(loans, "loans")
        predicate = Predicate("/loans", {"group": "true"})
        return Stub(response, predicate).to_mountebank()

    @staticmethod
    def make_group_stub(data, path='/chunkedGroups', pageSize=10):
        meta = {"total": len(data), "pageSize": pageSize}
        response = Response(data, "chunkedGroups", meta)
        predicate = Predicate(path);
        return Stub(response, predicate).to_mountebank()

    @staticmethod
    def make_loans_stub(data, path, pageSize=None):
        meta = {"total": len(data), "pageSize": pageSize} if pageSize else None
        response = Response(data, "loans", meta)
        predicate = Predicate(path);
        return Stub(response, predicate).to_mountebank()
