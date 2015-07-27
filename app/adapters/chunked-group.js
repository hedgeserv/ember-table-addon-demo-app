import DS from 'ember-data';
import Ember from 'ember';
import ENV from '../config/environment';

export default DS.RESTAdapter.extend({

  host: ENV.loansServerHost,

  findQuery: function(store, type, options) {
    var query = options || {};
    var urlSections = [];
    var groupingMetadata = options.groupingMetadata || [];
    for (var i=0; i< groupingMetadata.length; i++){
      var groupingKey = groupingMetadata[i].id;
      if(groupingKey){
        urlSections.push(Ember.String.pluralize(groupingKey));
      }
      if(query[groupingKey]){
        urlSections.push(query[groupingKey]);
        delete query[groupingKey];
      } else {
        break;
      }
    }
    delete options.groupingMetadata;
    var baseUrl = this.buildURL(type.typeKey, options, null, 'findQuery');
    urlSections.insertAt(0, baseUrl);
    return this.ajax(urlSections.join('/'), 'GET', {data: query});
  }
});
