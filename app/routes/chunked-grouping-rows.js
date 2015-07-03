import Ember from 'ember';
import LazyGroupRowArray from 'ember-table/models/lazy-group-row-array';

export default Ember.Route.extend({
  model: function () {
    var self = this;
    var groupingMetadata = [{id: 'accountSection'}, {id: 'accountType'}, {id: 'glAccountCode'}];
    var tableContent = LazyGroupRowArray.create({
      loadChildren: function (chunkIndex, parentQuery) {
        var query = {
          chunkedGroup: 1,
          section: chunkIndex + 1
        };
        Ember.setProperties(query, parentQuery);
        return self.store.find('chunked-group', query).then(function (result) {
          var meta = self.store.metadataFor('chunked-group');
          return {
            content: result,
            meta: {
              totalCount: meta.total,
              chunkSize: meta.page_size
            }
          };
        });
      },
      groupingMetadata: groupingMetadata
    });
    return tableContent;
  }
});
