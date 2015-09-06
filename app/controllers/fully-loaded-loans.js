import Ember from 'ember';
import AppColumnDefinition from '../models/app-column-definition';
import tablesMixin from '../mixins/features';

export default Ember.Controller.extend(tablesMixin, {

  title: 'Fully loaded set of loans',

  columns: function () {
    var idColumn, activityColumn, statusColumn;
    idColumn = AppColumnDefinition.create({
      width: 60,
      textAlign: 'text-align-left',
      headerCellName: 'Id',
      getCellContent: function(row) {
        return row.get('id');
      }
    });

    activityColumn = AppColumnDefinition.create({
      columnWidth: 150,
      textAlign: 'text-align-left',
      headerCellName: 'Activity',
      getCellContent: function (row) {
        return row.get('activity');
      }
    });

    statusColumn = AppColumnDefinition.create({
      columnWidth: 100,
      headerCellName: 'status',
      getCellContent: function (row) {
        return row.get('status');
      }
    });

    return [idColumn, activityColumn, statusColumn];
  }.property()
});
