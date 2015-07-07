import Ember from 'ember';
import ColumnDefinition from 'ember-table/models/column-definition';

export default Ember.Mixin.create({
  columns: function() {
    var columnsMetadata = [
      ["id",        "Id",         20],
      ["activity",  "Activity",   150],
      ["status",    "status",     100]
    ];

    return columnsMetadata.map(function(c) {
      return ColumnDefinition.create({
        columnWidth: c[2],
        headerCellName: c[1],
        getCellContent: function(row) {
          return row.get(c[0]);
        }
      });
    });
  }.property()
});
