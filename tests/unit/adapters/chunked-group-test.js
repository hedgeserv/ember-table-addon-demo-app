import Ember from 'ember';
import { moduleFor, test } from 'ember-qunit';
import { setupStore } from '../../helpers/store-util';
import ChunkedGroup from 'ember-table-addon-demo-app/models/chunked-group';
import ChunkedGroupAdapter from 'ember-table-addon-demo-app/adapters/chunked-group';
import ENV from '../../../config/environment';

var passedUrl, adapter, store;
var hostUrl =  ENV.loansServerHost;

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
  var params = {
    groupingMetadata: [{id: 'accountSection'}, {id: 'accountType'}],
    accountSection: 1
  };
  Ember.run(function () {
    store.find('chunkedGroup', params).then(function () {
      assert.equal(passedUrl, hostUrl + '/chunkedGroups/accountSections/1/accountTypes');
    });
  });
});

test('three level data', function(assert) {
  ajaxResponse({chunkedGroups: [{id: 1}]});
  this.subject();
  var params = {
    accountSection: 2,
    accountType: 3,
    groupingMetadata: [{id: 'accountSection'}, {id: 'accountType'}, {id: 'accountCode'}]
  };
  Ember.run(function () {
    store.find('chunkedGroup', params).then(function () {
      assert.equal(passedUrl, hostUrl + '/chunkedGroups/accountSections/2/accountTypes/3/accountCodes');
    });
  });
});
