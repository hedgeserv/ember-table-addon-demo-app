import Ember from 'ember';
import LazyGroupRowArray from 'ember-table/models/lazy-group-row-array';
export default Ember.Route.extend({

  model: function () {
    var self = this;
    var groupingMetadata = [{id: 'accountSection'}, {id: 'accountType'}, {id: 'accountCode'}];
    var tableContent = LazyGroupRowArray.create({
      loadChildren: function (chunkIndex, parentQuery) {
        var params = {content: parentQuery, groupingMetadata: groupingMetadata};
        Ember.setProperties(params.content, {section: chunkIndex + 1});
        var sortName = self.get('sortName');
        if(sortName){
          params.content.sortDirect = self.get('sortDirect');
          params.content.sortName = sortName;
        }
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
    setSortConditions: function (column) {
      var columnName = column.get('headerCellName').toLowerCase();
      this.set('sortName', columnName);
      this.set('sortDirect', column.get('currentDirect'));
    }
  }
});
