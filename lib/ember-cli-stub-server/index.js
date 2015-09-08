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
        host: 'localhost'
      }
    });
  },

  _startStubServer: function (middlewareContext) {
    var options = middlewareContext.options;
    var app = middlewareContext.app;
    if (['development', 'test'].indexOf(options.environment) !== -1) {
      var port = options.environment === 'development' ? 5555 : 8888;
      var serverOptions = {
        dataSetsDir: this.project.root + '/' + 'datasets',
        host: options.host,
        port: port
      };
      var startServer = require('./lib/stub-server');
      return startServer(app, serverOptions);
    }
  }

};
