import Ember from "ember";
import { module, test } from 'qunit';
import startApp from '../helpers/start-app';

var App;

module('Fully loaded set of loans', {
  beforeEach: function() {
    App = startApp();
  },
  afterEach: function() {
    Ember.run(App, App.destroy);
   }
 });

test("Should show all loans in a table", function(assert) {
  assert.expect(1);
  visit('/loans').then(function() {
    assert.equal(find('.ember-table-table-row').length, 503, "Page contains list of models 503");
   });
 });
