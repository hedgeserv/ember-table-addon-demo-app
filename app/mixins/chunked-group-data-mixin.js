import Ember from 'ember';
import LazyGroupRowArray from 'ember-table/models/lazy-group-row-array';

export default Ember.Mixin.create({
  sortName: null,
  sortDirect: null,

  model: function () {
    var self = this;
    var groupingMetadata = this.get('groupingMetadata');
    var tableContent = LazyGroupRowArray.create({
      loadChildren: function (chunkIndex, parentQuery) {
        var theQuery = {};
        Ember.setProperties(theQuery, parentQuery);
        theQuery.section = chunkIndex + 1;
        if (self.isLastLevel(parentQuery)) {
          var sortQuery = self.get('sortQuery');
          if(sortQuery){
            Ember.setProperties(theQuery, sortQuery);
          }
        }
        var params = {content: theQuery, groupingMetadata: groupingMetadata};
        return self.store.find('chunked-group', params).then(function (result) {
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
  },

  actions: {
    sortAction: function (sortConditions, sortingColumns) {
     var sortQuery = {};
      if (sortingColumns.get('isNotEmpty')) {
        //TODO: change to multiple sortQueries when group sort data is ready
        sortQuery = sortingColumns.map(function (column) {
          return {
            sortName: column.get('contentPath'),
            sortDirect: column.get('sortDirect')
          };
        })[0];
      }
      this.set('sortQuery', sortQuery);
    }
  },

  isLastLevel: function (parentQuery) {
    var groupingMetadata = this.get('groupingMetadata');
    var lastLevelQueryKey = groupingMetadata[groupingMetadata.length - 2].id;
    return parentQuery.hasOwnProperty(lastLevelQueryKey);
  },

  groupingMetadata: [{id: 'accountSection'}, {id: 'accountType'}, {id: 'accountCode'}]
});
