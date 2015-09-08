function createStub(allLoans) {
  var extend = require('util')._extend;
  var MBStub = require('./m-b-stub');
  var SortConditionProvider = require('./sort-condition-provider');
  var totalCount = 200;
  var pageSize = 50;
  var loans = allLoans.slice(0, 5);
  var url = '/loans';

  var stub = new MBStub({
    "path": url,
    query: {
      group: true
    }
  });

  stub.setBody({
    "meta": {
      "total": totalCount,
      "pageSize": pageSize,
      "date": new Date()
    },
    "loans": loans
  });
  return stub;
}

module.exports = createStub;
