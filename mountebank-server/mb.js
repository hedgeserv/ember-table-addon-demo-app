var http = require('http');
var MountBank = function() {};

MountBank.prototype.setImposter = function(imposter) {
  var req = http.request({
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
  req.write(JSON.stringify(imposter));
  req.end();
};

MountBank.prototype.clear = function (port){
  var req = http.request({
    host: 'localhost',
    port: 2525,
    path: '/imposters/' + port,
    method: 'DELETE',
    header: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    }
  }, function(res) {
    res.setEncoding('utf8');
  });
  req.end();
};

module.exports = MountBank;
