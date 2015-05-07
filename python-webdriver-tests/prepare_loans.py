import requests
import json

def prepare_loans(count):

    requests.delete('http://localhost:2525/imposters/'+str(8888))

    loans = map(lambda i: {"id": i, "activity": "activity-" + str(i), "status": "status" + str(i)}, range(count))

    stubs = [
        {
            "responses": [
                {
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
            ]
        }
    ]

    params = {
        "port": 8888,
        "protocol": "http",
        "name": "test",
        "stubs": stubs
    }
    requests.post('http://localhost:2525/imposters', data=json.dumps(params))
