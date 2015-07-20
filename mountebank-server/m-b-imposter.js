var MBImposter = function(port){
	this.port = port;
	this.protocol = 'http';
	this.stubs = [];
};

MBImposter.prototype.pushStub = function(stub){
	this.stubs.push(stub);
};

module.exports = MBImposter;
