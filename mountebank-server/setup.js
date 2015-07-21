var MB = require('./mb');
var MBImposter = require('./m-b-imposter');
var MBStub = require('./m-b-stub');

var PORT = 5555;
var mountBank = new MB();

// init imposter
var imposter = new MBImposter(PORT);


// lazy load multi columns sort
var lazyLoadStubs = require('./stubs-for-lazy-load');
imposter.pushStubs(lazyLoadStubs);

// send http request to mountbank
mountBank.setImposter(imposter);


