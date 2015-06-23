import Ember from 'ember';
import LazyGroupArray from 'ember-table/models/lazy-group-array';

export default Ember.Route.extend({
  model: function () {
    var self = this;
    return this.store.find('chunked-group', {chunkedGroup: 1, accountSection: 109, section: 1}).then(function (x) {
      var meta = self.store.metadataFor('chunked-group');
      return LazyGroupArray.create({
        topLevelCount: meta.total,
        chunkSize: meta.page_size,
        initContent: x,
        callback: function (chunkIndex) {
          return self.store.find('chunked-group', {chunkedGroup: 1, accountSection: 109, section: chunkIndex + 1}).then(function (data) {
            return data.get('content');
          });
        }
      });
    });
  }
});
