import Ember from "ember";
import DS from "ember-data";
import { module, test } from 'qunit';
import startApp from '../helpers/start-app';
import config from '../../config/environment';


var App;

module('Fully loaded set of loans', {
  beforeEach: function () {
    App = startApp();
  },
  afterEach: function () {
    Ember.run(App, App.destroy);
  }
});

//TODO: extract to util function,
//TODO: load data from dataset files
function setupImposter() {
  var loans = [];
  for(var i =0; i< 3500; i++) {
    loans.push({
      "id": i,
      "activity": "activity " + i,
      "status": "status " + i
    });
  }
  var setupPromise = Ember.$.ajax({
    type: "POST",
    url: config.mountebankServerHost + "/imposters",
    data: JSON.stringify({
      "port": 8888,
      "protocol": "http",
      "name": "test",
      "stubs": [
        {
          "responses": [
            {
              "is": {
                "headers": {
                  "Content-Type": "application/json",
                  "Access-Control-Allow-Origin": "*"
                },
                "body": JSON.stringify({
                  "header": {
                    "page": 1
                  },
                  "loans": loans
                })
              }
            }
          ],
          "predicates": [
            {
              "equals": {
                "method": "GET",
                "path": "/loans"
              }
            }
          ]
        }
      ]
    }),
    dataType: "json"
  });
  return setupPromise;
}
test("Should show all loans in a table", function (assert) {
  var deletePromise = Ember.$.ajax({
    type: "DELETE",
    url: config.mountebankServerHost + "/imposters/8888"
  });

  return deletePromise.then(function() {
    return setupImposter().then(function() {
      assert.expect(1);
      visit('/fully-loaded-loans');

      andThen(function () {
        assert.equal(find('.ember-table-body-container .ember-table-table-row').length, 3502, "Page contains list of models 3502");
      });
    });
  });
});
