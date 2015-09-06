var express = require('express');
var app = express();

var addSortAndChunkInfo = require('../mountebank-server/sort-and-chunk-decorator');
function decorateResponse(loadStub, req) {
  var response = loadStub.responses[0]['is'];
  response = JSON.parse(JSON.stringify(response));
  var _hidden = response.headers['_hidden'];
  delete response.headers['_hidden'];
  var SortCondition = require("../mountebank-server/sort-condition");
  var sortNameMap = _hidden['sortNameMap'];
  addSortAndChunkInfo(req, response, SortCondition, sortNameMap);
  return response;
}

app.get('/loans', function(req, res) {
  var loadStub = require('../mountebank-server/stubs-for-lazy-load');
  var response = decorateResponse(loadStub, req);
  res.set(response.headers);
  res.send(response.body);
});

var server = app.listen(5555, function() {

});
