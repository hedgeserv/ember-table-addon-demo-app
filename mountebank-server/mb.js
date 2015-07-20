var http = require('http');
var MountBank = function() {
  this.req = http.request({
    host: 'localhost',
    port: 2525,
    path: '/imposters',
    method: 'POST',
    header: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    }
  }, function(res) {
    res.setEncoding('utf8');
  });
};

MountBank.prototype.setImposter = function(imposter) {
  this.req.write(JSON.stringify(imposter));
  this.req.end();
};

module.exports = MountBank;
