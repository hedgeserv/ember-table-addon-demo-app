import Ember from 'ember';
import AppColumnDefinition from '../models/app-column-definition';
import ColumnGroupDefinition from 'ember-table/models/column-group-definition';
import tablesMixin from '../mixins/features';

export default Ember.Controller.extend(tablesMixin, {

  title: 'Group',

  columns: function () {

    var idColumn, activityColumn, statusColumn,
      nameColumn, useColumn, sectorColumn;

    idColumn = AppColumnDefinition.create({
      width: 150,
      textAlign: 'text-align-left',
      headerCellName: 'Id',
      groupName: 'word',
      getCellContent: function (row) {
        return row.get('id');
      }
    });

    activityColumn = AppColumnDefinition.create({
      columnWidth: 150,
      textAlign: 'text-align-left',
      headerCellName: 'Activity',
      groupName: 'hello',
      getCellContent: function (row) {
        return row.get('activity');
      }
    });

    statusColumn = AppColumnDefinition.create({
      columnWidth: 100,
      headerCellName: 'status',
      groupName: 'hello',
      getCellContent: function (row) {
        return row.get('status');
      }
    });

    nameColumn = AppColumnDefinition.create({
      columnWidth: 100,
      headerCellName: 'Name',
      getCellContent: function (row) {
        return row.get('name');
      }
    });

    useColumn = AppColumnDefinition.create({
      columnWidth: 100,
      headerCellName: 'Use',
      getCellContent: function (row) {
        return row.get('use');
      }
    });

    sectorColumn = AppColumnDefinition.create({
      columnWidth: 260,
      headerCellName: 'Sector',
      getCellContent: function (row) {
        return row.get('sector');
      }
    });

    var Group1 = ColumnGroupDefinition.create({
      cellStyle: "text-red",
      innerColumnStyle: "text-blue",
      firstColumnStyle: "bg-gray",
      lastColumnStyle: "bg-lightgray",
      groupStyle: "text-center",
      headerCellName: 'Group1',
      innerColumns: [activityColumn, statusColumn]
    });

    var Group2 = ColumnGroupDefinition.create({
      cellStyle: "text-red",
      innerColumnStyle: "text-blue",
      firstColumnStyle: "bg-gray",
      lastColumnStyle: "bg-lightgray",
      groupStyle: "text-center",
      headerCellName: 'Person',
      innerColumns: [nameColumn, useColumn, sectorColumn]
    });

    return [idColumn, Group1, Group2];

  }.property()

});
