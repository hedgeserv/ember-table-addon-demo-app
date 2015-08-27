var extend = require('util')._extend;
var fs = require('fs');
var util = require('util');
var wrapePredicate = function (options) {
  return {
    "and": [{"deepEquals": {
      "method": options.method || "GET",
      "path": options.path || ''
    }},
    {"exists": {
      "query": {
          "group": (options.query||{}).group || false
      }
    }}]
  };
};

var script = fs.readFileSync(__dirname + '/sort-behaviors.js').toString();

var MBStub = function (options) {
  this.predicates = [];
  this.responses = [];

  var predicate = wrapePredicate(options);
  this.predicates.push(predicate);
};

MBStub.prototype.setBody = function (body) {
  if (typeof (body) === 'object') {
    body = JSON.stringify(body);
  }
  this.responses[0] = {
    "is": {
      "headers": {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
      "body": body
    },
    "_behaviors": {
      "decorate": util.format(script, __dirname, "{\
        accountSection: 'GL Account Section',\
        accountType: 'GL Account Type',\
        accountCode: 'GL Account Code'\
      }")
    }
  };
}

module.exports = MBStub;
