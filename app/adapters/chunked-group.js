import DS from 'ember-data';

export default DS.RESTAdapter.extend({

  host: 'http://localhost:5555',

  findQuery: function(store, type, options) {
    var url = this.buildURL(type.typeKey, options, null, 'findQuery');
    var resource = options.resource;
    var urlArray = resource.reduce(function (res, condition) {
      if(condition.name){
        res.push(condition.name);
      }
      if(condition.value){
        res.push(condition.value);
      }
      return res;
    }, [url]);
    return this.ajax(urlArray.join('/'), 'GET', { data: options.query});
  }
});
