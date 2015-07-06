import Ember from 'ember';
import { moduleFor, test } from 'ember-qunit';
import { setupStore } from '../../helpers/store-util';
import ChunkedGroup from 'ember-table-addon-demo-app/models/chunked-group';
import ChunkedGroupAdapter from 'ember-table-addon-demo-app/adapters/chunked-group';

var passedUrl, adapter, store;

function ajaxResponse(value) {
  adapter.ajax = function(url) {
    passedUrl = url;
    return Ember.run(Ember.RSVP, 'resolve', Ember.copy(value, true));
  };
}

moduleFor('adapter:chunked-group', 'Unit | Adapter | chunked group', {
  beforeEach: function() {
    var env = setupStore({
      chunkedGroup: ChunkedGroup,
      adapter: ChunkedGroupAdapter
    });

    store = env.store;
    adapter = env.adapter;
  }
});

// Replace this with your real tests.
test('only one level', function(assert) {
  ajaxResponse({chunkedGroups: [{id: 1}]});
  this.subject();

  Ember.run(function () {
    store.find('chunkedGroup', 1).then(function () {
      assert.equal(passedUrl, 'http://localhost:5555/chunkedGroups/1');
    });
  });
});

test('three level data', function(assert) {
  ajaxResponse({chunkedGroups: [{id: 1}]});
  this.subject();
  var content = [{value: 1}, {name: 'accountSection', value: 2}, {name: 'accountType', value: 3}];

  Ember.run(function () {
    store.find('chunkedGroup', {resource: content, query:{}}).then(function () {
      assert.equal(passedUrl, 'http://localhost:5555/chunkedGroups/1/accountSection/2/accountType/3');
    });
  });
});
