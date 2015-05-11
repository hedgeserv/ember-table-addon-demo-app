import Ember from "ember";
import config from '../../config/environment';

export default {
  stubForOne: function (method, path, body) {
    return this.stubFor([{
      method: method,
      path: path,
      body: body
    }]);
  },

  stubFor: function (stubs) {
    var mbStubs = stubs.map(function (stub) {
      return {
        "responses": [
          {
            "is": {
              "headers": {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"
              },
              "body": JSON.stringify(stub.body)
            }
          }
        ],
        "predicates": [
          {
            "equals": {
              "method": stub.method,
              "path": stub.path
            }
          }
        ]
      };
    });

    return Ember.$.ajax({
      type: "DELETE",
      url: config.mountebankServerHost + "/imposters/8888"
    }).then(function () {
      return Ember.$.ajax({
        type: "POST",
        url: config.mountebankServerHost + "/imposters",
        data: JSON.stringify({
          "port": 8888,
          "protocol": "http",
          "name": "test",
          "stubs": mbStubs
        }),
        dataType: "json"
      });
    }, function(error) {
      if(error.status === 0) {
        console.log("Failed to set up Mountebank, please make sure Mountebank is started with option --allowCORS " +
          "and the version is no less than 1.2.122.");
      }
    });
  }
};
