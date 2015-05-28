import Ember from 'ember';
import ColumnDefinition from 'ember-table/models/column-definition';
import LazyArray from 'ember-table/models/lazy-array';

export default Ember.Controller.extend({

  queryParams:['totalCount'],
  totalCount:100,
  sortName: null,
  sortDirect: null,

  columns: function () {
    var idColumn, activityColumn, statusColumn;
    idColumn = ColumnDefinition.create({
      columnWidth: 20,
      textAlign: 'text-align-left',
      headerCellName: 'Id',
      sortBy: function(prev, next){ 
        return prev.get('id') - next.get('id');
      },
      getCellContent: function(row) {
        return row.get('id');
      }
    });
    activityColumn = ColumnDefinition.create({
      columnWidth: 150,
      textAlign: 'text-align-left',
      headerCellName: 'Activity',
      getCellContent: function (row) {
        return row.get('activity');
      }
    });
    statusColumn = ColumnDefinition.create({
      columnWidth: 100,
      headerCellName: 'status',
      sortBy: function(prev, next){ 
        return prev.get('status').charCodeAt() - next.get('status').charCodeAt(); 
      },
      getCellContent: function (row) {
        return row.get('status');
      }
    });

    return [idColumn, activityColumn, statusColumn];
  }.property(),

  model: function () {
    var self = this;
    var totalCount = this.get('totalCount');
    return LazyArray.create({
      chunkSize: 50,
      totalCount: totalCount,
      callback: function (pageIndex) {
        var params = {section: pageIndex + 1};
        var sortName = self.get('sortName');
        if(sortName){
          params.sortDirect = self.get('sortDirect');
          params.sortName = sortName;
        }
        return self.store.find('loan', params).then(function (data) {
          return data.get('content');
        });
      }
    });
  }.property(),

  actions: {
    apply:function(){
      window.location.reload(true);
    },

    setSortConditions: function (column) {
      var columnName = column.get('headerCellName').toLowerCase();
      this.set('sortName', columnName);
      this.set('sortDirect', column.get('currentDirect'));
    }
  }
});
