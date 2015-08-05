import Ember from 'ember';
import LazyGroupRowArray from 'ember-table/models/lazy-group-row-array';

export default Ember.Mixin.create({
  sortName: null,
  sortDirect: null,
  model: function () {
    var self = this;
    var groupingMetadata = this.get('groupingMetadata');
    return LazyGroupRowArray.create({
      loadChildren: function (chunkIndex, parentQuery, sortingColumns) {
        var parameters = {};
        Ember.setProperties(parameters, parentQuery);
        parameters.section = chunkIndex + 1;
        if (self.isLastLevel(parentQuery)) {
          var sortQuery = self.makeSortQuery(sortingColumns);
          Ember.setProperties(parameters, sortQuery);
        }
        parameters.groupingMetadata = groupingMetadata;
        return self.store.find('chunked-group', parameters).then(function (result) {
          var meta = self.store.metadataFor('chunked-group');
          return {
            content: result,
            meta: {
              totalCount: meta.total,
              chunkSize: meta.pageSize
            }
          };
        });
      },
      groupingMetadata: groupingMetadata
    });
  },

  actions: {
    sortAction: function (sortingColumns) {
      this.set('sortingColumns', sortingColumns);
    }
  },

  isLastLevel: function (parentQuery) {
    var groupingMetadata = this.get('groupingMetadata');
    var lastLevelQueryKey = groupingMetadata[groupingMetadata.length - 2].id;
    return parentQuery.hasOwnProperty(lastLevelQueryKey);
  },

  groupingMetadata: [{id: 'accountSection'}, {id: 'accountType'}, {id: 'accountCode'}]
});
