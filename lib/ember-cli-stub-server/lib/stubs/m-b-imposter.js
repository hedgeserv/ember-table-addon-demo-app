var MBImposter = function(port){
	this.port = port;
	this.protocol = 'http';
	this.stubs = [];
};

MBImposter.prototype.pushStub = function(stub){
	this.stubs.push(stub);
};

MBImposter.prototype.pushStubs = function(stubs){
	this.stubs = this.stubs.concat(stubs);
};

module.exports = MBImposter;
