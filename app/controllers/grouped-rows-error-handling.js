import Ember from 'ember';
import ColumnDefinition from 'ember-table/models/column-definition';
import ChunkedGroupDataMixin from '../mixins/chunked-group-data-mixin';

export default Ember.Controller.extend(ChunkedGroupDataMixin, {

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
        getCellContent: function (row) {
          return row.get(titleAndName[1]);
        }
      });
    });
  }.property(),

  tableContent: Ember.computed(function() {
    return this.model();
  }),

  groupingMetadata: [{id: 'accountSection'}, {id: 'errorGroupName'}, {id: 'glAccountCode'}],

  isErrorThrown: Ember.computed(function () {
    return !!this.get('loadError');
  }).property('loadError'),

  errorDescription: Ember.computed.alias('loadError'),
  group: null,
  chunkIndex: null,

  actions: {
    handleDataLoadingError: function (errorMessage, group, chunkIndex) {
      this.set('loadError', errorMessage);
      this.set('group', group);
      this.set('chunkIndex', chunkIndex);
    }
  }

});
