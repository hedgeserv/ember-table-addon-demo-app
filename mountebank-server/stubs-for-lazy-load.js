var helper = require('./helper');
var extend = require('util')._extend;
var MBStub = require('./m-b-stub');
var stubs = [];
var totalCount = 200;
var pageSize = 50;
var loans = helper.loadAllLoans().slice(0, totalCount);
var url = '/loans'
var singleSortColumns = ['id'];
var multiSortColumns = ['activity', 'status'];
var sortDirects = ['asc', 'desc'];

// set sorted stubs
var sortColumns = helper.product(multiSortColumns, multiSortColumns, true);
sortColumns.push(singleSortColumns);
sortColumns.forEach(function (sortNames){
  var sortConditions = sortNames.map(function(sortName){
    return {sortName: sortName};
  });
  var directs = sortNames.length === 1 ? [['asc'], ['desc']] : helper.product(sortDirects, sortDirects);
  directs.forEach(function(subDirects){
    var conditions = sortConditions.map(function(condition, idx){
      var sortCondition = helper.clone(condition);
      sortCondition['sortDirect'] = subDirects[idx];
      return sortCondition;
    });
    var sortedloans = helper.multiSort(loans , conditions);
    var localQuery = helper.sortConditionsToQuery(conditions);
    helper.concat(stubs, createStubs(sortedloans, localQuery));
  });
});


// set unsort stubs
helper.concat(stubs, createStubs(loans, {}));


module.exports = stubs;


// private function

function createStubs(loans, query){
  return helper.splitToChunks(loans, pageSize).map(function(chunkData, index) {
    var pageIndex = index + 1;
    var localQuery = extend({"section": pageIndex}, query);
    var stub = createStub(localQuery);
    stub.setBody({
      "meta": createMeta(pageIndex),
      "loans": chunkData
    });
    return stub;
  });
}

function createStub(query) {
  return new MBStub({
    "query": query,
    "path": url
  });
}

function createMeta(pageIndex) {
  return {
    "total": totalCount,
    "page": pageIndex,
    "page_size": pageSize,
    "date": new Date()
  }
}
