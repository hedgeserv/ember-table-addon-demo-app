import DS from 'ember-data';

export default DS.RESTSerializer.extend({
  extractMeta: function(store, type, payload) {
    if (payload && payload.header) {
      store.setMetadataFor(type, { header: payload.header });
      delete payload.header;
    }
  }
});
