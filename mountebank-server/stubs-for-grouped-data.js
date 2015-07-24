var MBStub = require('./m-b-stub');
var helper = require('./helper');
var extend = require('util')._extend;
var url = '/chunkedGroups';
var records = helper.loadJsonFile('three-levels-of-grouping.json');
var stubs = [];
var pageSize = 10;
var resourceNames = ['accountSections', 'accountTypes', 'accountCodes'];
var singleSortColumns = ['id'];
var multiSortColumns = ['Beginning DR (Base)', 'Beginning CR (Base)', 'Net Beginning (Base)'];
var sortDirects = ['asc', 'desc'];
var sortNameMap = {
  'Beginning DR (Base)': 'beginningDr', 
  'Beginning CR (Base)': 'beginningCr', 
  'Net Beginning (Base)': 'netBeginning'
};
for (var i = 0; i < 20; i++) {
  records[0].children[2].children.push(helper.clone(records[0].children[2].children[0]));
}
for (var i = 0; i < 20; i++) {
  records[0].children.push(helper.clone(records[0].children[2]));
}

generateRecordId(records, 0);

var sortColumns = helper.product(multiSortColumns, multiSortColumns, true);
sortColumns.push(singleSortColumns);
leafCollections(records[0], function (accountSection, accountType){
	var localUrl = url + "/accountSections/" + accountSection['id'] + '/accountTypes/' + accountType['id'] + '/accountCodes';
	var localLoans = removeChildren(accountType.children);
	sortColumns.forEach(function (sortNames){
		var sortConditions = sortNames.map(function(sortName){
      return {"sortName": sortName};
    });
    var directs = sortNames.length === 1 ? [['asc'], ['desc']] : helper.product(sortDirects, sortDirects);
    directs.forEach(function(subDirects){
      var conditions = sortConditions.map(function(condition, idx){
        var sortCondition = helper.clone(condition);
        sortCondition['sortDirect'] = subDirects[idx];
        return sortCondition;
      });
      var sortedLoans = helper.multiSort(localLoans, conditions);
      conditions = conditions.map(function(condition){
      	condition['sortName'] = sortNameMap[condition['sortName']] || condition['sortName'];
      	return condition;
      });
      var localQuery = helper.sortConditionsToQuery(conditions);
      var localStubs = createchunkedStubs(localUrl, sortedLoans, localQuery);
      helper.concat(stubs, localStubs);
    });
	});
});

// unsort grouped stubs

var unsortStubs = doMakeNestedStubs({
  children: records
}, resourceNames, {});

helper.concat(stubs, unsortStubs);


module.exports = stubs;


function generateRecordId(records, parentId) {
  for (var i = 0; i < records.length; i++) {
    var record = records[i];
    record.id = (i + 1) + parentId * 100;
    if (record.children) {
      generateRecordId(record.children, record.id);
    }
  }
}

function removeChildren(obj) {
  var doRemoveChildren = function(object) {
    var cloneObject = helper.clone(object);
    cloneObject.children = [];
    return cloneObject;
  }
  if (Array.isArray(obj)) {
    return obj.map(function(x) {
      return doRemoveChildren(x);
    });
  }
  return doRemoveChildren(obj);
}

function doMakeNestedStubs(theRecord, resourceNames, parentQuery, localUrl) {
  localUrl = localUrl || url;
  var localStubs = [];
  if (theRecord.children) {
  	var chunkedGroups = removeChildren(theRecord.children);
    helper.concat(localStubs, createchunkedStubs(localUrl, chunkedGroups, parentQuery));
    theRecord.children.forEach(function(value) {
      var theQuery = helper.clone(parentQuery);
      var tempUrl = localUrl;
      if (tempUrl !== url) {
        tempUrl += '/' + value.id;
      }
      tempUrl += '/' + resourceNames[0];
      localStubs = localStubs.concat(doMakeNestedStubs(value, resourceNames.slice(1), theQuery, tempUrl));
    });
  }
  return localStubs;
}

function createchunkedStubs(path, loans, query) {
  return helper.splitToChunks(loans, pageSize).map(function(chunkedData, index) {
  	var pageIndex = index + 1;
    var localQuery = extend({"section": pageIndex}, query);

    var stub = new MBStub({
      "path": path,
      "query": localQuery
    });
    stub.setBody({
      "meta": {
        "total": loans.length,
        "page": pageIndex,
        "page_size": pageSize,
        "date": new Date()
      },
      'chunkedGroups': chunkedData
    });
    return stub;
  });
}

function leafCollections(record, callBack){
	record.children.forEach(function(accountSection) {
  	accountSection.children.forEach(function(accountType) {
  		callBack(accountSection, accountType);
  	});
  });
}




