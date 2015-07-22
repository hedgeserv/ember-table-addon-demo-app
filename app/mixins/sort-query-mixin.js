import Ember from 'ember';

export default Ember.Mixin.create({
  sortQuery: Ember.computed(function() {
    var sortingColumns = this.get('sortingColumns');
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
  }).property('sortingColumns._columns')
});
