import Ember from 'ember';

export default Ember.Mixin.create({
  makeSortQuery: function(sortingColumns) {
    var sortQuery = {};
    if (sortingColumns && sortingColumns.get('isNotEmpty')) {
      sortQuery = sortingColumns.map(function (column){
        return column;
      }).reduce(function (query, column, index) {
        Ember.set(query, 'sortNames[%@]'.fmt(index), column.get('contentPath'));
        Ember.set(query, 'sortDirects[%@]'.fmt(index), column.get('sortDirect'));
        return query;
      }, {});
    }
    return sortQuery;
  }
});
