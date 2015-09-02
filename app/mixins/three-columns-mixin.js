import Ember from 'ember';
import AppColumnDefinition from '../models/app-column-definition';

var defaultSortFn = function(prev, next){
  var prevStr = this.getCellContent(prev).toString();
  var nextStr = this.getCellContent(next).toString();
  return prevStr.localeCompare(nextStr);
};

export default Ember.Mixin.create({
  columns: function() {
    var columnsMetadata = this.get('columnsMetadata');
    return columnsMetadata.map(function(c) {
      return AppColumnDefinition.create({
        width: c[2],
        headerCellName: c[1],
        contentPath: c[0],
        sortBy: c[3] || defaultSortFn,
        getCellContent: function(row) {
          return Ember.get(row, c[0]);
        }
      });
    });
  }.property(),

  columnsMetadata: [
      ["id",        "Id",         60],
      ["activity",  "Activity",   150],
      ["status",    "status",     100]
  ]
});
