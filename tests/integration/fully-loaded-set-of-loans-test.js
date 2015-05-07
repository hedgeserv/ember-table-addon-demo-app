import Ember from "ember";
import DS from "ember-data";
import { module, test } from 'qunit';
import startApp from '../helpers/start-app';
import mb from './mountebank-util';

var App;

module('Fully loaded set of loans', {
  beforeEach: function () {
    App = startApp();

    App.prepareLoans =  function (count) {
      var loans = [];
      for (var i = 0; i < count; i++) {
        loans.push({
          "id": i,
          "activity": "activity " + i,
          "status": "status " + i
        });
      }
      return {
        "header": {
          "page": 1
        },
        "loans": loans
      };
    };

  },
  afterEach: function () {
    Ember.run(App, App.destroy);
  }
});


test("Should show all loans in a table", function (assert) {
  var loans = App.prepareLoans(3500);

  return mb.stubForOne("GET", "/loans", loans).then(function () {
    assert.expect(1);

    visit('/fully-loaded-loans');

    andThen(function () {
      assert.equal(find('.ember-table-body-container .ember-table-table-row').length, 3502, "Page contains list of models 3502");
    });
  });
});
