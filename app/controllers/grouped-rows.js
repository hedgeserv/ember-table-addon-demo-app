import Ember from 'ember';
import ColumnDefinition from 'ember-table/models/column-definition';

export default Ember.Controller.extend({

  columns: function () {
    var columnTitleAndNames = [
      ["GL Account Section", "glAccountSection"],
      ["GL Account Type", "glAccountType"],
      ["GL Account Code", "glAccountCode"],
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
