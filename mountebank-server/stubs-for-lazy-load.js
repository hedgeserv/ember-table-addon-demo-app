var helper = require('./helper');

var extend = require('util')._extend;
var MBStub = require('./m-b-stub');
var SortConditionProvider = require('./sort-condition-provider');
var totalCount = 200;
var pageSize = 50;
var loans = helper.loadAllLoans().slice(0, 1000);
var url = '/loans'

var stub = new MBStub({
  "path": url
});

stub.setBody({
  "meta": {
    "total": totalCount,
    "pageSize": pageSize,
    "date": new Date()
  },
  "loans": loans
})

module.exports = stub
