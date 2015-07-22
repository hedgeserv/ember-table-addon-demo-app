var http = require('http');
var extend = require('util')._extend;
var format = require('util').format;
var helper = require('./helper');
var MBStub = require('./m-b-stub');

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
  // stubs.push(makeGroupDataStub(allLoans));
  // makeSortedLoans(allLoans.slice(0, 1000), pageSize, stubs);
  // stubs = stubs.concat(makePagedStubs(allLoans.slice(0, 200), pageSize, "loans", "/loans"));
  // stubs.push(makeAllLoansStub(allLoans));
  stubs = stubs.concat(makeNestedGroupingStubs());
  return stubs;
}

function makeSortedLoans(allLoans, pageSize, stubs) {
  loans = allLoans.slice(0, 200);
  var sortFunctionMap = {'id': intCompare};
  var columns = ['activity', 'status'];
  var sortColumns = helper.product(columns, columns, true);
  sortColumns.push(['id']);
  var sortDirects = ['asc', 'desc'];
  sortColumns.forEach(function(sortNames){
    var sortConditions = sortNames.map(function(sortName){
      return {sortName: sortName};
    });
    var directs = sortNames.length === 1 ? [['asc'], ['desc']] : helper.product(sortDirects, sortDirects);
    directs.forEach(function(subDirects){
      var conditions = sortConditions.map(function(condition, idx){
        var sortCondition = helper.clone(condition);
        sortCondition['sortDirect'] = subDirects[idx];
        return sortCondition;
      })
      var sortedloans = multiSort(loans , conditions);
      var localStubs = makeMultiColumnsSortedPageLoans(sortedloans, pageSize, 'loans', '/loans', conditions);
      localStubs.forEach(function(stub){
        stubs.push(stub);
      });
    });
  });       
}

function makeMultiColumnsSortedPageLoans(loans, pageSize, contentKey, path, sortConditions){
  var query = sortConditions.reduce(function(res, sortCondition, index){
    res['sortNames['+index+']'] = sortCondition['sortName'];
    res['sortDirects['+index+']'] = sortCondition['sortDirect'];
    return res;
  }, {});
  return makePagedStubs(loans, pageSize, contentKey, path, query);
};

function makePagedStubs(allRecords, pageSize, contentKey, path, query) {
  var stubs = [];
  var pageIndex = 1;
  while ((pageIndex - 1) * pageSize < allRecords.slice(0, 1000).length) {
    stubs.push(makePerPageStub(allRecords, pageIndex, pageSize, contentKey, path, query));
    pageIndex++;
  }
  return stubs;
}

function makePerPageStub(allRecords, pageIndex, pageSize, contentKey, path, query) {
  query = query || {};
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
  var theQuery = cloneObject(query);
  theQuery["section"] = pageIndex.toString();
  return makeStub(body, path, theQuery);
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

function makeNestedGroupingStubs() {
  var records = loadJsonFile('three-levels-of-grouping.json');
  for(var i=0; i<20; i++) {
    records[0].children[2].children.push(cloneObject(records[0].children[2].children[0]));
  }
  for (var i=0; i< 20; i++) {
    records[0].children.push(cloneObject(records[0].children[2]));
  }

  generateRecordId(records, 0);
  var stubs =  doMakeNestedStubs({
    children: records
  }, ['accountSections', 'accountTypes', 'accountCodes'], {});

  var columns = ['Beginning DR (Base)', 'Beginning CR (Base)', 'Net Beginning (Base)'];
  var sortColumns = helper.product(columns, columns, true);
  sortColumns.push(['id']);
  var sortDirects = ['asc', 'desc'];
  var sortNameMap = {
    'Beginning DR (Base)': 'beginningDr', 
    'Beginning CR (Base)': 'beginningCr', 
    'Net Beginning (Base)': 'netBeginning'
  };
  records[0].children.forEach(function(accountSection) {
    accountSection.children.forEach(function(accountType) {
      var url = "/chunkedGroups/accountSections/" + accountSection['id'] + '/accountTypes/' + accountType['id'] + '/accountCodes';
      var localLoans = noChildren(accountType.children);
      sortColumns.forEach(function(sortNames) {
        var sortConditions = sortNames.map(function(sortName){
          return {sortName: sortName};
        });
        var directs = sortNames.length === 1 ? [['asc'], ['desc']] : helper.product(sortDirects, sortDirects);
        directs.forEach(function(subDirects){
          var conditions = sortConditions.map(function(condition, idx){
            var sortCondition = helper.clone(condition);
            sortCondition['sortDirect'] = subDirects[idx];
            sortCondition['sortName'] = sortNameMap[sortCondition['sortName']];
            return sortCondition;
          });
          var localStubs = makeMultiColumnsSortedPageLoans(multiSort(localLoans, sortConditions), 10, "chunkedGroups", url, conditions);
          stubs = stubs.concat(localStubs);
        });
      });
    });
  });
  return stubs;
}

function doMakeNestedStubs(theRecord, resourceNames, parentQuery, url) {
  url = url || '/chunkedGroups';
  var stubs = [];
  if (theRecord.children) {
    stubs = stubs.concat(makePagedStubs(noChildren(theRecord.children), 10, "chunkedGroups", url, parentQuery));
    theRecord.children.forEach(function(value) {
      var theQuery = cloneObject(parentQuery);
      var tempUrl = url;
      if (tempUrl !== '/chunkedGroups'){
        tempUrl += '/' + value.id;
      }
      tempUrl += '/' + resourceNames[0];
      stubs = stubs.concat(doMakeNestedStubs(value, resourceNames.slice(1), theQuery, tempUrl));
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
  var stub = new MBStub({
    "query": query,
    "path": path
  });
  stub.setBody(body);
  return stub;
  // var predicate = {
  //   "deepEquals": {
  //     "method": "GET",
  //     "path": path
  //   }
  // };
  // if (query) {
  //   extend(predicate["deepEquals"], {query: query});
  // }
  // return {
  //   "responses": [{
  //     "is": {
  //       "headers": {
  //         "Content-Type": "application/json",
  //         "Access-Control-Allow-Origin": "*"
  //       },
  //       "body": JSON.stringify(body)
  //     }
  //   }],
  //   "predicates": [predicate]
  // };
}

function loadJsonFile(fileName) {
  var fs = require('fs');
  return JSON.parse(fs.readFileSync(__dirname + '/../datasets/' + fileName));
}

function multiSort(loans, sortConditions){
  var sortStatesMap = {'asc': 1, 'desc': -1};
  var sortFn = function (prev, next) {
    for (var i = 0; i < sortConditions.length; i++) {
      var sortCondition = sortConditions[i];
      var sortState = sortStatesMap[sortCondition.sortDirect];
      var singleColumnCompareResult = sortState * compare(prev, next, sortCondition.sortName);
      if (singleColumnCompareResult !== 0) {
        return singleColumnCompareResult;
      }
    }
    return 0;
  };
  return loans.slice().sort(sortFn);
}

function compare(prev, next, key){
  return (prev[key] + '').localeCompare('' + next[key]);
}

