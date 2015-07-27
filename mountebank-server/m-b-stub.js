var extend = require('util')._extend;

var wrapePredicate = function(options) {
  return {
    "deepEquals": {
      "method": options.method || "GET",
      "path": options.path || '',
      "query": options.query
    }
  };
};

var MBStub = function(options) {
  this.predicates = [];
  this.responses = [];

  var predicate = wrapePredicate(options);
  this.predicates.push(predicate);
};

MBStub.prototype.setBody = function(body) {
  if (typeof(body) === 'object') {
    body = JSON.stringify(body);
  }
  this.responses[0] = {
    "is": {
      "headers": {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
      "body": body
    }
  };
}

module.exports = MBStub;
