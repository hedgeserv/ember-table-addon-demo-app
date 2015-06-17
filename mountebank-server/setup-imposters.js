var http = require('http');
var extend = require('util')._extend;

stubLoans(loadAllLoans());

function loadAllLoans() {
  var allLoans = [1, 2, 3, 4, 5, 6, 7].map(function(index) {
    return loadJsonFile(index + '.json');
  }).reduce(function(previous, current){
    return previous.concat(current.loans);
  }, []);
  return allLoans;
}

function stubLoans(allLoans) {
  var options = {
    host: 'localhost',
    port: 2525,
    path: '/imposters'  ,
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
  stubs.push(makeGroupDataStubs(allLoans));
  makeSortedLoans(allLoans.slice(0, 1000), pageSize, stubs);
  var pageIndex = 1;
  while ((pageIndex - 1) * pageSize < allLoans.slice(0, 1000).length) {
    stubs.push(makePerPageStub(allLoans, pageIndex, pageSize));
    pageIndex++;
  }

  stubs.push(makeAllLoansStub(allLoans));
  stubs.push(makeGroupedRecordStubs());
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
  return makeLoansStub({
      "header": {
        "total": allLoans.length,
        "page": pageIndex,
        "page_size": pageSize,
        "date": new Date()
      },
      "loans": loans
    },
    {
      "section": pageIndex.toString()
    }
  );
}

function makeAllLoansStub(allLoans) {
  return makeLoansStub({
    "header": {
      "total": allLoans.length,
      "date": new Date()
    },
    "loans": allLoans
  });
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
  return makeLoansStub({
      "header": {
        "total": sortedLoans.length,
        "page": pageIndex,
        "page_size": pageSize,
        "date": new Date()
      },
      "loans": loans
    }, {
      "section": pageIndex.toString(),
      "sortDirect": sortDirect,
      "sortName": sortName
    }
  );
}

function makeGroupDataStubs(allLoans) {
  var loans = allLoans.slice(0, 5).map(function(group, index) {
    // third loans is not grouped data
    group.isGroupRow = index !== 2;
    group.groupName = 'Group ' + index;
    if (index%2 === 1) {
      group['children'] = allLoans.slice(index*100, index*120);
    }
    return group;
  });
  return makeLoansStub({
    "header": {
      "total": loans.length,
      "date": new Date()
    },
    "loans": loans
  }, {"group": "true"});
}

function makeGroupedRecordStubs() {
  var records = loadJsonFile('three-levels-of-grouping.json');
  generateRecordId(records, 0);
  return makeStub({records: records}, '/records/1');
}

function generateRecordId(records, parentId) {
  for (var i=0; i < records.length; i++) {
    var record = records[i];
    record.id = (i + 1) + parentId * 100 ;
    if (record.children) {
      generateRecordId(record.children, record.id);
    }
  }
}

function makeLoansStub(body, query) {
  return makeStub(body, "/loans", query);
}

function makeStub(body, path, query) {
  var predicate = {
    "equals": {
      "method": "GET",
      "path": path
    }
  };
  if (query) {
    extend(predicate, {"equals": {query: query}});
  }
  return {
    "responses": [{
      "is": {
        "headers": {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
        "body": JSON.stringify(body)
      }
    }],
    "predicates": [predicate]
  };
}

function loadJsonFile(fileName) {
  var fs = require('fs');
  return JSON.parse(fs.readFileSync(__dirname + '/../datasets/' + fileName));
}

