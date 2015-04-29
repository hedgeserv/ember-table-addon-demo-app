import Ember from "ember";
import startApp from './../helpers/start-app';
import { describe, beforeEach, afterEach, it } from 'mocha';
import { expect } from 'chai';

var App;

describe('Fully loaded set of loans', function() {
  beforeEach(function () {
    App = startApp();
  });

  afterEach(function () {
    Ember.run(App, App.destroy);
  });

  it('Should show all loans in a table', function() {
    this.timeout(5000); //Render time exceeds 2000ms
    //Given there are 3502 loans
    visit('/loans').then(function() {
      expect(find('.ember-table-table-row').length).to.equal(503);
    });
  });
});

