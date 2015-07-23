import Ember from 'ember';

export default Ember.Mixin.create({
  makeSortQuery: function(sortingColumns) {
    var sortQuery = {};
    if (sortingColumns && sortingColumns.get('isNotEmpty')) {
      //TODO: change to multiple sortQueries when group sort data is ready
      sortQuery = sortingColumns.map(function (column) {
        return {
          sortName: column.get('contentPath'),
          sortDirect: column.get('sortDirect')
        };
      })[0];
    }
    return sortQuery;
  }
});
