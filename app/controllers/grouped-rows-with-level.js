import Ember from 'ember';
import ColumnDefinition from 'ember-table/models/column-definition';
import GroupedRowIndicatorWithLevel from './../views/grouped-row-indicator-with-level';
export default Ember.Controller.extend({

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
  }.property(),


  indicatorView: GroupedRowIndicatorWithLevel
});
