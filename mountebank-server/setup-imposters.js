var http = require('http');
var extend = require('util')._extend;
var format = require('util').format;

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
  stubs.push(makeGroupDataStub(allLoans));
  makeSortedLoans(allLoans.slice(0, 1000), pageSize, stubs);
  stubs = stubs.concat(makePagedStubs(allLoans, pageSize, "loans", "/loans"));
  stubs.push(makeAllLoansStub(allLoans));
  stubs.push(makeGroupedRecordStub());
  stubs = stubs.concat(makeNestedGroupingStubs());
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

function makePagedStubs(allRecords, pageSize, contentKey, path) {
  var stubs = [];
  var pageIndex = 1;
  while ((pageIndex - 1) * pageSize < allRecords.slice(0, 1000).length) {
    stubs.push(makePerPageStub(allRecords, pageIndex, pageSize, contentKey, path));
    pageIndex++;
  }
  return stubs;
}

function makePerPageStub(allRecords, pageIndex, pageSize, contentKey, path) {
  var startRow = (pageIndex-1) * pageSize;
  var records = allRecords.slice(startRow, startRow + pageSize);
  var body = {
    "meta": {
      "total": allRecords.length,
      "page": pageIndex,
      "page_size": pageSize,
      "date": new Date()
    }
  };
  body[contentKey] = records;
    return makeStub(body, path,
    {
      "section": pageIndex.toString()
    }
  );
}

function makeAllLoansStub(allLoans) {
  return makeLoansStub({
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
      "meta": {
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

function makeGroupDataStub(allLoans) {
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
    "meta": {
      "total": loans.length,
      "date": new Date()
    },
    "loans": loans
  }, {"group": "true"});
}

function makeGroupedRecordStub() {
  var records = loadJsonFile('three-levels-of-grouping.json');
  generateRecordId(records, 0);
  return makeStub({reports: records}, '/reports/1');
}

function makeNestedGroupingStubs() {
  var records = loadJsonFile('three-levels-of-grouping.json');
  for(var i=0; i<20; i++) {
    records[0].children[2].children.push(cloneObject(records[0].children[2].children[0]));
  }
  for (var i=0; i< 20; i++) {
    records[0].children.push(cloneObject(records[0].children[2]));
  }

  generateRecordId(records, 0);
  return doMakeNestedStubs({
    children: records
  }, ['chunkedGroups', 'accountSections', 'accountTypes', 'accountCodes'], '');
}

function doMakeNestedStubs(theRecord, resourceNames, parentPath) {
  var stubs = [];
  if (theRecord.children) {
    var body = { "meta": { "date": new Date()}};
    var path = parentPath + '/' + resourceNames[0];
    stubs = stubs.concat(makePagedStubs(noChildren(theRecord.children), 10, resourceNames[0], path));
    theRecord.children.forEach(function(value) {
      var nextParentPath = format("%s/%s/%s", parentPath, resourceNames[0], value.id);
      stubs = stubs.concat(doMakeNestedStubs(value, resourceNames.slice(1), nextParentPath));
    });
  }
  return stubs;
}

function noChildren(obj) {
  if (Array.isArray(obj)) {
    return obj.map(function(x) {
      return doRemoveChildren(x);
    })
  }
  return doRemoveChildren(obj);
}

function doRemoveChildren(obj) {
  var clone = cloneObject(obj);
  clone.children = [];
  return clone;
}

function cloneObject(obj) {
  return JSON.parse(JSON.stringify(obj));
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
    extend(predicate["equals"], {query: query});
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

