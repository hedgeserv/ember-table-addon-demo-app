'use strict';

module.exports = {
  name: 'ember-cli-stub-server',

  serverMiddleware: function (middlewareContext) {
    this._startStubServer(middlewareContext);
  },

  testemMiddleware: function (app) {
    this._startStubServer({
      app: app,
      options: {
        environment: 'test',
        host: 'localhost',
        ui: {
          writeLine: console.log
        }
      }
    });
  },

  _startStubServer: function (middlewareContext) {
    var options = middlewareContext.options;
    var port = options.environment === 'development' ? 5555 : 8888;
    if (['development', 'test'].indexOf(options.environment) !== -1) {
      var serverOptions = {
        dataSetsDir: this.project.root + '/' + 'datasets'
      };
      var stubServer = require('./lib/stub-server')(serverOptions);
      stubServer.listen(port, function () {
        options.ui.writeLine('Stub server on http://' + displayHost(options.host) + ':' + port);
      });
    }
    if (['development', 'test', 'ci'].indexOf(options.environment) !== -1) {
      proxyToStub(middlewareContext.app, options.host + ':' + port);
      options.ui.writeLine('Proxy api request to http://' + displayHost(options.host) + ':' + port);
    }
  }
};

function proxyToStub(app, host) {
  var proxy = require('express-http-proxy');
  app.use('/api', proxy(host, {}));
}
function displayHost(specifiedHost) {
  return specifiedHost === '0.0.0.0' ? 'localhost' : specifiedHost;
}
