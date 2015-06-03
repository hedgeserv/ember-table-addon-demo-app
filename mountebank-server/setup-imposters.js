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
  makeSortedLoans(allLoans.slice(0, 1000), pageSize, stubs);

  var pageIndex = 1;
  while ((pageIndex - 1) * pageSize < allLoans.slice(0, 1000).length) {
    stubs.push(makePerPageStub(allLoans, pageIndex, pageSize));
    pageIndex++;
  }

  stubs.push(makeAllLoansStub(allLoans));
  return stubs;
}

function makeSortedLoans(allLoans, pageSize, stubs) {
  var sortFunctionMap = {'id': intCompare};
  ['id', 'activity', 'status'].forEach(function (columnName) {
    var sortFunction = sortFunctionMap[columnName] ? sortFunctionMap[columnName] : stringCompare;
    var ascLoans = [].concat(allLoans).sort(function (prev, next) {
      return stringCompare(prev[columnName], next[columnName]);
    });
    var descLoans = [].concat(allLoans).sort(function (prev, next) {
      return -1 * sortFunction(prev[columnName], next[columnName]);
    });
    var pageIndex = 1;
    while ((pageIndex - 1) * pageSize < allLoans.length) {
      stubs.push(makeSortedPageLoans(ascLoans, pageIndex, pageSize, columnName, 'asc'));
      stubs.push(makeSortedPageLoans(descLoans, pageIndex, pageSize, columnName, 'desc'));
      pageIndex++;
    }

  });
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
          "section": pageIndex.toString()
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

function stringCompare(prev, next) {
  if (prev === next)
    return 0;
  return prev > next ? 1: -1;
}

function intCompare(prev, next) {
  return parseInt(prev) - parseInt(next);
}

function makeSortedPageLoans(sortedLoans, pageIndex, pageSize, sortName, sortDirect){
  var startRow = (pageIndex-1) * pageSize;
  var loans = sortedLoans.slice(startRow, startRow + pageSize);
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
            "total": sortedLoans.length,
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
          "section": pageIndex.toString(),
          "sortDirect": sortDirect,
          "sortName": sortName
        }
      }
    }
  ]};
}



