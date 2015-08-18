// MountBank Models
var MBStub = require('./m-b-stub');
var MB = require('./mb');
var MBImposter = require('./m-b-imposter');
var fs = require('fs');
var util = require('util');

var PORT = 5555;
var mountBank = new MB();

// clear
mountBank.clear(PORT);

// init imposter
var imposter = new MBImposter(PORT);

// Grouping column loans
// TODO: this stub will remove after neatening features
var groupingColumnStub = require('./stub-for-grouping-column');
imposter.pushStub(groupingColumnStub);

// Grouped data
var groupedStubs = require('./stubs-for-grouped-data');
imposter.pushStubs(groupedStubs);


// loans
var loadStub = require('./stubs-for-lazy-load');
imposter.pushStub(loadStub);

// send http request to mountbank
mountBank.setImposter(imposter);
