import Ember from 'ember';
import GrandTotalRow from 'ember-table/models/grand-total-row';

export default Ember.Route.extend({
  model: function () {
    var self = this;
    var groupingMetadata = [{id: 'accountSection'}, {id: 'accountType'}];
    var tableContent = GrandTotalRow.create({
      loadChildren: function (chunkIndex, parentQuery) {
        var query = {
          section: chunkIndex + 1
        };
        Ember.setProperties(query, parentQuery);
        return self.store.find('chunked-group', {content: query, groupingMetadata: groupingMetadata}).then(function (result) {
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
      loadGrandTotal: function () {
        return self.store.find('chunked-group', {content: {section: 1}}).then(function (result) {
          return result.get('firstObject');
        });
      },
      groupingMetadata: groupingMetadata,
      grandTotalTitle: "Total"
    });
    return tableContent;
  }
});
