import Ember from 'ember';

export default Ember.Route.extend({
  model: function () {
    var self = this;
    var groupingMetadata = [{id: 'accountSection'}, {id: 'accountType'}, {id: 'accountCode'}];
    var tableContent = Ember.Object.create({
      loadChildren: function (chunkIndex, sortingColumns, groupQuery) {
        var query = {
          section: chunkIndex + 1,
          groupQuery: groupQuery
        };
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
      groupingMetadata: groupingMetadata,
      grandTotalTitle: "Total"
    });
    return tableContent;
  }
});
