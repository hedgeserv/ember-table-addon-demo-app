import Ember from 'ember';
import ColumnDefinition from 'ember-table/models/column-definition';

export default Ember.Mixin.create({
  columns: function () {
    var columnTitleAndNames = [
      ["Id", "id"],
      ["Beginning DR (Base)", "beginningDr"],
      ["Beginning CR (Base)", "beginningCr"],
      ["Net Beginning (Base)", "netBeginning"],
      ["Activity DR (Base)", "activityDr"],
      ["Activity CR (Base)", "activityCr"],
      ["Net Activity (Base)", "netActivity"],
      ["Ending DR (Base)", "endingDr"],
      ["Ending CR (Base)", "endingCr"],
      ["Net Ending (Base)", "netEnding"]
    ];
    return columnTitleAndNames.map(function (titleAndName) {
      return ColumnDefinition.create({
        headerCellName: titleAndName[0],
        contentPath: titleAndName[1],
        getCellContent: function (row) {
          return row.get(titleAndName[1]);
        },
        sortBy: function(prev, next){
          var prevName = prev.get(titleAndName[1]).toUpperCase();
          var nextName = next.get(titleAndName[1]).toUpperCase();
          if(typeof prevName === 'number') {
            return prevName - nextName;
          }
          else {
            return (prevName < nextName) ? -1 : (prevName > nextName) ? 1 : 0;
          }
        }
      });
    });
  }.property()
});
