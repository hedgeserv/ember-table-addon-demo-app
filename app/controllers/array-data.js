import Ember from 'ember';
import LazyArray from 'ember-table/models/lazy-array';
import SortQueryMixin from '../mixins/sort-query-mixin';
import tablesMixin from '../mixins/features';
import AppColumnDefinition from '../models/app-column-definition';
import ColumnGroupDefinition from 'ember-table/models/column-group-definition';

export default Ember.Controller.extend(SortQueryMixin, tablesMixin, {

  title: "Array Data",
  features: [
    {
      name: 'Lazy loading',
      icon: 'fa-flash'
    },
    {
      name: 'Column group',
      icon: 'fa-arrows-v'
    },
    {
      name: 'Sort',
      icon: 'fa-sort'
    }
  ],

  sortName: null,
  sortDirect: null,

  model: function () {
    var self = this;
    return LazyArray.create({
      chunkSize: 50,
      totalCount: 200,
      callback: function (pageIndex, sortingColumns) {
        var params = {section: pageIndex + 1};
        var sortQuery = self.makeSortQuery(sortingColumns);
        Ember.setProperties(params, sortQuery);
        return self.store.find('loan', params).then(function (data) {
          return data.get('content');
        });
      }
    });
  }.property(),

  columns: function () {

    var idColumn = AppColumnDefinition.create({
      width: 80,
      headerCellName: 'Id',
      getCellContent: function (row) {
        return row.get('id');
      }
    });

    var nameColumn = AppColumnDefinition.create({
      width: 100,
      headerCellName: 'Name',
      getCellContent: function (row) {
        return row.get('name');
      }
    });

    var countryColumn = AppColumnDefinition.create({
      width: 100,
      headerCellName: 'Country',
      getCellContent: function (row) {
        return row.get('country');
      }
    });

    var townColumn = AppColumnDefinition.create({
      width: 150,
      headerCellName: 'Town',
      getCellContent: function (row) {
        return row.get('town');
      }
    });

    var activityColumn = AppColumnDefinition.create({
      width: 150,
      headerCellName: 'Activity',
      getCellContent: function (row) {
        return row.get('activity');
      }
    });

    var statusColumn = AppColumnDefinition.create({
      width: 120,
      headerCellName: 'Status',
      getCellContent: function (row) {
        return row.get('status');
      }
    });
    var useColumn = AppColumnDefinition.create({
      width: 150,
      headerCellName: 'Use',
      getCellContent: function (row) {
        return row.get('use');
      }
    });

    var locationColumnGroup = ColumnGroupDefinition.create({
      groupStyle: "text-center",
      headerCellName: 'Location',
      innerColumns: [countryColumn, townColumn]
    });

    return [idColumn, nameColumn, locationColumnGroup, activityColumn, statusColumn, useColumn];

  }.property(),

  actions: {
    sortAction: function (sortingColumns) {
      this.set('sortingColumns', sortingColumns);
    }
  }
});
