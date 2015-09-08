var helper = require('./stubs/helper');

module.exports = function startServer(app, options) {
  options = options || {};

  var addSortAndChunkInfo = require('./stubs/sort-and-chunk-decorator');

  function decorateResponse(loadStub, req) {
    var response = loadStub.responses[0]['is'];
    response = JSON.parse(JSON.stringify(response));
    var _hidden = response.headers['_hidden'];
    delete response.headers['_hidden'];
    var SortCondition = require("./stubs/sort-condition");
    var sortNameMap = _hidden['sortNameMap'];
    addSortAndChunkInfo(req, response, SortCondition, sortNameMap);
    return response;
  }

  app.get('/loans', function (req, res) {
    var createStub;
    var allLoans = helper.loadAllLoans(options.dataSetsDir);
    if (req.query.group) {
      createStub = require('./stubs/stub-for-grouping-column');
    } else {
      createStub = require('./stubs/stubs-for-lazy-load');
    }
    var response = decorateResponse(createStub(allLoans), req);
    res.set(response.headers);
    res.send(response.body);
  });

  var createGroupedStubs = require('./stubs/stubs-for-grouped-data');
  var records = helper.loadJsonFile('three-levels-of-grouping.json', options.dataSetsDir);
  var groupedStubs = createGroupedStubs(records);
  groupedStubs.forEach(function (stub) {
    app.get(stub.predicates[0]['and'][0]['deepEquals']['path'], function (req, res) {
      var response = decorateResponse(stub, req);
      res.set(response.headers);
      res.send(response.body);
    });
  });
  return app.listen(options.port, function () {
    console.log('Stub server on http://' + displayHost(options.host) + ':' + options.port);
  });
};


function displayHost(specifiedHost) {
  return specifiedHost === '0.0.0.0' ? 'localhost' : specifiedHost;
}

