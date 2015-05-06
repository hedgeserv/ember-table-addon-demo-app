var fs = require('fs');
var http = require('http');

var allLoans = [1, 2, 3, 4, 5, 6, 7].map(function(index) {
  return JSON.parse(fs.readFileSync(__dirname + '/../datasets/' + index + '.json'));
}).reduce(function(previous, current){
  return previous.concat(current.loans);
}, []);

stubLoans(allLoans);

function stubLoans(allLoans) {
  var options = {
    host: 'localhost',
    port: 2525,
    path: '/imposters',
    method: 'POST',
    header: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    }
  };
  var imposter = JSON.stringify({
    "port": 5555,
    "protocol": "http",
    "name": "loans",
    "stubs": makeStubs(allLoans)
  });

  var req = http.request(options, function(res) {
    res.setEncoding('utf8');
  });
  req.write(imposter);
  req.end();
}

function makeStubs(allLoans) {
  var stubs = [];
  var pageSize = 50;
  var pageIndex = 1;
  while ((pageIndex - 1) * pageSize < allLoans.length) {
    stubs.push(makePerPageStub(allLoans, pageIndex, pageSize));
    pageIndex++;
  }
  stubs.push(makeAllLoansStub(allLoans));
  return stubs;
}

function makePerPageStub(allLoans, pageIndex, pageSize) {
  var startRow = (pageIndex-1) * pageSize;
  var loans = allLoans.slice(startRow, startRow + pageSize);
  return {
    "responses": [
    {
      "is": {
        "headers": {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
        "body": JSON.stringify({
          "header": {
            "total": allLoans.length,
            "page": pageIndex,
            "page_size": pageSize,
            "date": new Date()
          },
          "loans": loans
        })
      }
    }],
    "predicates": [
    {
      "equals": {
        "method": "GET",
        "path": "/loans",
        "query": {
          "page": pageIndex.toString()
        }
      }
    }
  ]};
}

function makeAllLoansStub(allLoans) {
  return {
    "responses": [
      {
        "is": {
          "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
          "body": JSON.stringify({
            "header": {
              "total": allLoans.length,
              "date": new Date()
            },
            "loans": allLoans
          })
        }
      }],
    "predicates": [
      {
        "equals": {
          "method": "GET",
          "path": "/loans"
        }
      }
    ]};
}




