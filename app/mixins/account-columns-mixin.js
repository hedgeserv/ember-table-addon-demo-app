import Ember from 'ember';
import AppColumnDefinition from '../models/app-column-definition';

export default Ember.Mixin.create({
  columns: function () {
    var columnTitleAndNames = [
      ["Id", "id", "decimal"],
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
      return AppColumnDefinition.create({
        headerCellName: titleAndName[0],
        contentPath: titleAndName[1],
        dataType: titleAndName[2],
        getCellContent: function (row) {
          return Ember.get(row, titleAndName[1]);
        }
      });
    });
  }.property()
});
