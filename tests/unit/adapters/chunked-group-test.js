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
  var query = {
    groupingMetadata: [{id: 'accountSection'}, {id: 'accountType'}],
    content: {
      accountSection: 1
    }
  };
  Ember.run(function () {
    store.find('chunkedGroup', query).then(function () {
      assert.equal(passedUrl, 'http://localhost:5555/chunkedGroups/accountSections/1/accountTypes');
    });
  });
});

test('three level data', function(assert) {
  ajaxResponse({chunkedGroups: [{id: 1}]});
  this.subject();
  var content = {accountSection: 2, accountType: 3};
  var groupingMetadata = [{id: 'accountSection'}, {id: 'accountType'}, {id: 'accountCode'}];
  Ember.run(function () {
    store.find('chunkedGroup', {groupingMetadata: groupingMetadata, content: content}).then(function () {
      assert.equal(passedUrl, 'http://localhost:5555/chunkedGroups/accountSections/2/accountTypes/3/accountCodes');
    });
  });
});
