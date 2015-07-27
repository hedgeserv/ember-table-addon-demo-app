import Ember from 'ember';
import LazyArray from 'ember-table/models/lazy-array';
import ThreeColumnsMixin from '../mixins/three-columns-mixin';
import SortQueryMixin from '../mixins/sort-query-mixin';

export default Ember.Controller.extend(ThreeColumnsMixin, SortQueryMixin, {
  queryParams:['totalCount'],
  sortName: null,
  sortDirect: null,

  model: function () {
    var self = this;
    return LazyArray.create({
      chunkSize: 50,
      totalCount: 200,
      callback: function (pageIndex, sortingColumns) {
        var params = {section: pageIndex + 1};
        var sortQuery = self.makeSortQuery(sortingColumns);
        Ember.setProperties(params, sortQuery);
        return self.store.find('loan', params).then(function (data) {
          return data.get('content');
        });
      }
    });
  }.property(),

  columnsMetadata: [
    ["id", "Id", 20, function(prev, next){
      return Ember.get(prev, 'id') - Ember.get(next, 'id');
    }],
    ["activity", "Activity", 150],
    ["status", "status", 150],
    ["use", "Use", 150],
    ["sector", "Sector", 150]
  ],

  actions: {
    apply:function(){
      window.location.reload(true);
    },

    sortAction: function(sortingColumns) {
      this.set('sortingColumns', sortingColumns);
    }
  }
});
