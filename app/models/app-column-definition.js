import Ember from 'ember';
import ColumnDefinition from 'ember-table/models/column-definition';

export default ColumnDefinition.extend({
  // Specified type of data, eg: datetime, decimal, percentage, and string.
  dataType: null,

  parseFnMap: Ember.computed(function() {
    var column = this;
    var numberParse = function(item) {
      return Number(column.getCellContent(item));
    };
    var percentageParse = function(item) {
      return Number(column.getCellContent(item).replace("%", ""));
    };
    var dateParse = function(item) {
      return Date.parse(column.getCellContent(item)) || 0;
    };
    var defaultParse = function(item) {
      return column.getCellContent(item);
    };
    return {
      decimal: numberParse,
      percentage: percentageParse,
      datetime: dateParse,
      date: dateParse,
      default: defaultParse
    };
  }),

  _sortParseFn: Ember.computed(function() {
    var dataType = this.get('dataType');
    return this.get('parseFnMap.' + dataType) || this.get('parseFnMap.default');
  }).property('dataType'),

  sortBy: function(prev, next) {
    var parseFn = this.get('_sortParseFn');
    var prevValue = parseFn(prev);
    var nextValue = parseFn(next);
    return Ember.compare(prevValue, nextValue);
  }
});
