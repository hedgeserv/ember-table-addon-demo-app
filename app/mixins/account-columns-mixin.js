import Ember from 'ember';
import ColumnDefinition from 'ember-table/models/column-definition';

export default Ember.Mixin.create({
  columns: function () {
    var columnTitleAndNames = [
      ["Id", "id"],
      ["GL Account Section", "accountSection"],
      ["GL Account Type", "accountType"],
      ["GL Account Code", "accountCode"],
      ["GL Account Description", "glAccountDescription"],
      ["Beginning DR (Base)", "beginningDR"],
      ["Beginning CR (Base)", "beginningCR"],
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
        getCellContent: function (row) {
          return row.get(titleAndName[1]);
        }
      });
    });
  }.property()
});
