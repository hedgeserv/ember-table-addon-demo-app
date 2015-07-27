var MBStub = require('./m-b-stub');
var helper = require('./helper');

var loans = helper.loadAllLoans();

var stub = new MBStub({path: '/loans'});

stub.setBody({loans: loans});

module.exports = stub;
