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
    if (['development', 'test'].indexOf(options.environment) !== -1) {
      var port = options.environment === 'development' ? 5555 : 8888;
      var serverOptions = {
        dataSetsDir: this.project.root + '/' + 'datasets'
      };
      var stubServer = require('./lib/stub-server')(serverOptions);
      stubServer.listen(port, function () {
        options.ui.writeLine('Stub server on http://' + displayHost(options.host) + ':' + port);
      });
    }
  }
};

function displayHost(specifiedHost) {
  return specifiedHost === '0.0.0.0' ? 'localhost' : specifiedHost;
}
