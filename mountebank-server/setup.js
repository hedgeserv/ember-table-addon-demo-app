var MB = require('./mb');
var MBImposter = require('./m-b-imposter');
var MBStub = require('./m-b-stub');

var mountBank = new MB();
var PORT = 5555;
var HOST = 'http://localhost'
var location = HOST + PORT;

// init imposter
var imposter = new MBImposter(PORT);


// 

var stub = new MBStub({
	path: '/name',
	query: {
		name: 1
	}
});
stub.setBody({name: 'Hello'});
imposter.pushStub(stub);

var stub = new MBStub({
	path: '/name'
});
stub.setBody({
	name: 'Hello',
	params: true
});
imposter.pushStub(stub);



// send http request to mountbank
mountBank.setImposter(imposter);

