import DS from 'ember-data';
import Ember from 'ember';
import ENV from '../config/environment';

export default DS.RESTAdapter.extend({

  host: ENV.loansServerHost,

  findQuery: function(store, type, options) {
    var query = options || {};
    var urlSections = [];
    var groupQuery = options.groupQuery;
    groupQuery.upperGroupings.forEach(function(x) {
      urlSections.push(x[0] + "s");
      urlSections.push(Ember.get(x[1], 'id'));
    });
    if (groupQuery.key) {
      urlSections.push(groupQuery.key + "s");
    }
    delete query.groupQuery;
    var baseUrl = this.buildURL(type.typeKey, options, null, 'findQuery');
    urlSections.insertAt(0, baseUrl);
    return this.ajax(urlSections.join('/'), 'GET', {data: query});
  }
});
