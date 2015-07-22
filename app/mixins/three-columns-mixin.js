import Ember from 'ember';
import ColumnDefinition from 'ember-table/models/column-definition';
var defaultSortFn = function(prev, next){
  var prevStr = this.getCellContent(prev).toString();
  var nextStr = this.getCellContent(next).toString();
  return prevStr.localeCompare(nextStr);
};

export default Ember.Mixin.create({
  columns: function() {
    var columnsMetadata = this.get('columnsMetadata');
    return columnsMetadata.map(function(c) {
      return ColumnDefinition.create({
        columnWidth: c[2],
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
      ["id",        "Id",         20],
      ["activity",  "Activity",   150],
      ["status",    "status",     100]
  ]
});
