import Ember from 'ember';
import ColumnDefinition from 'ember-table/models/column-definition';

export default Ember.Controller.extend({

  queryParams: ['totalCount'],
  totalCount: 100,

  columns: function() {
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
      getCellContent: function(row) {
        return row.get('activity');
      }
    });

    statusColumn = ColumnDefinition.create({
      columnWidth: 100,
      headerCellName: 'status',
      getCellContent: function(row) {
        return row.get('status');
      }
    });

    return [idColumn, activityColumn, statusColumn];
  }.property()

});
