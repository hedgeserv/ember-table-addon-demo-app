var http = require('http');
var extend = require('util')._extend;
var format = require('util').format;
var helper = require('./helper');

// MountBank Models
var MBStub = require('./m-b-stub');
var MB = require('./mb');
var MBImposter = require('./m-b-imposter');

var PORT = 5555;
var mountBank = new MB();

// init imposter
var imposter = new MBImposter(PORT);

// Grouped data
var groupedStubs = require('./stubs-for-grouped-data');
imposter.pushStubs(groupedStubs);


// Grouping column loans
var groupingColumnStub = require('./stub-for-grouping-column');
imposter.pushStub(groupingColumnStub);

// Lazy loaded loans
var lazyLoadStubs = require('./stubs-for-lazy-load');
imposter.pushStubs(lazyLoadStubs);

// Fully loaded loans
var fullyLoansStub = require('./stub-for-fully-loans');
imposter.pushStub(fullyLoansStub);

// send http request to mountbank
mountBank.setImposter(imposter);
