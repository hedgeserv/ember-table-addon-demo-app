import Ember from 'ember';
import ColumnDefinition from 'ember-table/models/column-definition';
import ColumnGroupDefinition from 'ember-table/models/column-group-definition';
import LazyArray from 'ember-table/models/lazy-array';

export default Ember.Controller.extend({

  title: 'Group',
  sortName: null,
  sortDirect: null,

  columns: function () {
    var idColumn, activityColumn, statusColumn,
      nameColumn, useColumn, sectorColumn;

    idColumn = ColumnDefinition.create({
      columnWidth: 150,
      textAlign: 'text-align-left',
      headerCellName: 'Id',
      getCellContent: function (row) {
        return row.get('id');
      },
      sortBy: function(prev, next){
        return prev.get('id') - next.get('id');
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
      headerCellName: 'Status',
      getCellContent: function (row) {
        return row.get('status');
      },
      sortBy: function(prev, next){
        return prev.get('status').charCodeAt() - next.get('status').charCodeAt();
      }
    });

    nameColumn = ColumnDefinition.create({
      columnWidth: 100,
      headerCellName: 'Name',
      getCellContent: function (row) {
        return row.get('name');
      }
    });

    useColumn = ColumnDefinition.create({
      columnWidth: 100,
      headerCellName: 'Use',
      getCellContent: function (row) {
        return row.get('use');
      }
    });

    sectorColumn = ColumnDefinition.create({
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
      innerColumns: [nameColumn, useColumn]
    });

    return [idColumn, Group1, sectorColumn, Group2];

  }.property(),

  model: function () {
    var self = this;
    var totalCount = 500;
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
