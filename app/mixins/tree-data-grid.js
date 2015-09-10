import Ember from 'ember';
import AppColumnDefinition from '../models/app-column-definition';
import ColumnGroupDefinition from 'ember-table/models/column-group-definition';

export default Ember.Mixin.create({
  groupingMetadata: Ember.computed.oneWay('model.groupingMetadata'),

  columns: function () {
    var idColumn = this._makeColumn('Id', 'id');
    var groupColumns = ['Beginning', 'Activity', 'Ending'].map(function (groupTitle) {
      var titleLowerCase = groupTitle.toLowerCase();
      var columnGroup = ColumnGroupDefinition.create({
        headerCellName: groupTitle,
        innerColumns: [
          this._makeColumn(groupTitle + ' DR', titleLowerCase + 'Dr'),
          this._makeColumn(groupTitle + ' CR', titleLowerCase + 'Cr'),
          this._makeColumn('Net ' + groupTitle, 'net' + groupTitle)
            ]
        });
      columnGroup.setProperties(this.getColumnGroupStyles());
        return columnGroup;
    }.bind(this));
    return [idColumn].concat(groupColumns);
  }.property(),

  _makeColumn: function (headerCellName, contentPath) {
    return AppColumnDefinition.create({
      headerCellName: headerCellName,
      contentPath: contentPath
    });
  },

  getColumnGroupStyles: function() {
    return {};
  },

  actions: {
    sortGrouper: function (grouper) {
      var states = ['asc', 'desc', undefined];
      var oldState = Ember.get(grouper, 'sortDirection');
      var index = states.indexOf(oldState) + 1;
      Ember.set(grouper, 'sortDirection', states[index % 3]);
    }
  }
});
