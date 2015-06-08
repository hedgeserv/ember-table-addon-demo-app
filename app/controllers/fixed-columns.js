import Ember from 'ember';
import ColumnDefinition from 'ember-table/models/column-definition';
import LazyArray from 'ember-table/models/lazy-array';

export default Ember.Controller.extend({

  queryParams:['totalCount'],
  totalCount:100,

  columns: function () {
    var idColumn, activityColumn, statusColumn;
    idColumn = ColumnDefinition.create({
      columnWidth: 20,
      textAlign: 'text-align-left',
      headerCellName: 'Id',
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
        return self.store.find('loan', {section: pageIndex + 1}).then(function (data) {
          return data.get('content');
        });
      }
    });
  }.property()

});
