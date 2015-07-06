import Ember from 'ember';
import LazyGroupRowArray from 'ember-table/models/lazy-group-row-array';

export default Ember.Mixin.create({
  sortName: null,
  sortDirect: null,

  model: function () {
    var self = this;
    var tableContent = LazyGroupRowArray.create({
      loadChildren: function (chunkIndex, parentQuery) {
        var query = {
          chunkedGroup: 1,
          section: chunkIndex + 1
        };
        var sortName = self.get('sortName');
        if(sortName){
          query.sortDirect = self.get('sortDirect');
          query.sortName = sortName;
        }
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
      onLoadError: function(error) {
        self.set('loadError', error);
      },
      groupingMetadata: self.get('groupingMetadata')
    });
    return tableContent;
  },

  groupingMetadata: [{id: 'accountSection'}, {id: 'accountType'}, {id: 'glAccountCode'}],

  actions: {
    setSortConditions: function (column) {
      var columnName = column.get('headerCellName').toLowerCase();
      this.set('sortName', columnName);
      this.set('sortDirect', column.get('currentDirect'));
    }
  }
});
