import DS from 'ember-data';
import Ember from 'ember';
import ENV from '../config/environment';

export default DS.RESTAdapter.extend({

  host: ENV.loansServerHost,

  findQuery: function(store, type, options) {

    var url = this.buildURL(type.typeKey, options, null, 'findQuery');
    var urlArray = [url];
    var groupingMetadata = options.groupingMetadata || [];
    var query = options.content || {};
    if (options.grandTotal){
      groupingMetadata = groupingMetadata.copy();
      groupingMetadata.unshift({id: ''});
    }
    for (var i=0; i< groupingMetadata.length; i++){
      var groupingKey = groupingMetadata[i].id;
      if(groupingKey){
        urlArray.push(Ember.String.pluralize(groupingKey));
      }
      if(query[groupingKey]){
        urlArray.push(query[groupingKey]);
        delete query[groupingKey];
      } else {
        break;
      }
    }
    return this.ajax(urlArray.join('/'), 'GET', {data: query});
  }
});
