var helper = require('./stubs/helper');

module.exports = function stubServer(options) {
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

  var app = {
    get: function(path, handler) {
      this[path] = handler;
    }
  };
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

  return createServer(app);
};

function createServer(app) {
  var parse = require('url').parse;
  return require('http').createServer(function (req, res) {
    var request = parse(req.url, true);
    var response = {
      set: function (headers) {
        res.writeHead(200, headers);
      },
      send: function (body) {
        res.write(body);
        res.end();
      }
    };
    var handler = app[request.pathname];
    if(handler) {
      handler(request, response);
    } else {
      res.writeHead(404, {});
      res.end();
    }
  });
}
