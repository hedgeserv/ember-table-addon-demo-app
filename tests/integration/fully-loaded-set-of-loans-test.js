import Ember from "ember";
import DS from "ember-data";
import { module, test } from 'qunit';
import startApp from '../helpers/start-app';

var App;

module('Fully loaded set of loans', {
  beforeEach: function () {
    App = startApp();
  },
  afterEach: function () {
    Ember.run(App, App.destroy);
  }
});


test("Should show all loans in a table", function (assert) {
  prepareLoans(1000);

  assert.expect(1);

  visit('/fully-loaded-loans');

  andThen(function () {
    assert.equal(find('.ember-table-body-container .ember-table-table-row').length, 1002, "Page contains list of models 3502");
  });
});
