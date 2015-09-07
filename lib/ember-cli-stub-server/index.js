'use strict';

module.exports = {
  name: 'ember-cli-stub-server',

  serverMiddleware: function(middlewareContext) {
    var emberOptions = middlewareContext.options;
    var app = middlewareContext.app;
    if (emberOptions.environment === 'development') {
      var serverOptions = {
        dataSetsDir: this.project.root + '/' + 'datasets',
        host: emberOptions.host
      };
      var startServer = require('./lib/stub-server');
      return startServer(app, serverOptions);
    }
  }

};
