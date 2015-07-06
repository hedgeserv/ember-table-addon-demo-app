import Ember from 'ember';
import ChunkedGroupDataMixin from '../mixins/chunked-group-data-mixin';

export default Ember.Route.extend(ChunkedGroupDataMixin, {

  model: function () {
    var self = this;
    var groupingMetadata = [{id: 'accountSection'}, {id: 'accountType'}, {id: 'glAccountCode'}];
    var tableContent = LazyGroupRowArray.create({
      loadChildren: function (chunkIndex, parentQuery) {
        var params = {};
        params.resource = [{
          value: 1
        }];
        params.query = {section: chunkIndex + 1};
        var sortName = self.get('sortName');
        if(sortName){
          params.query.sortDirect = self.get('sortDirect');
          params.query.sortName = sortName;
        }
        Ember.setProperties(params.resource, parentQuery);
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
