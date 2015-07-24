var helper = require('./helper');
var extend = require('util')._extend;
var MBStub = require('./m-b-stub');
var SortConditionProvider = require('./sort-condition-provider');
var stubs = [];
var totalCount = 200;
var pageSize = 50;
var loans = helper.loadAllLoans().slice(0, totalCount);
var url = '/loans'
var sortColumns = ['id', 'activity', 'status'];
var sortDirects = ['asc', 'desc'];

var sortConditionProvider =  new SortConditionProvider(sortColumns);

sortConditionProvider.forEach(function(sortCondition){
  var sortedloans = sortCondition.sort(loans);
  var localStubs = createStubs(sortedloans, sortCondition.toQuery());
  helper.concat(stubs, localStubs);
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
