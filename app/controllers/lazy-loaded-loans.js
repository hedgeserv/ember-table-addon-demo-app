import Ember from 'ember';
import LazyArray from 'ember-table/models/lazy-array';
import ThreeColumnsMixin from '../mixins/three-columns-mixin';

export default Ember.Controller.extend(ThreeColumnsMixin, {
  queryParams:['totalCount'],
  sortName: null,
  sortDirect: null,

  model: function () {
    var self = this;
    return LazyArray.create({
      chunkSize: 50,
      totalCount: 200,
      callback: function (pageIndex) {
        var params = {section: pageIndex + 1};
        var sortName = self.get('sortName');
        if(sortName){
          params['sortDirects[0]'] = self.get('sortDirect');
          params['sortNames[0]'] = sortName;
        }
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
    ["status", "status", 150]
  ],

  actions: {
    apply:function(){
      window.location.reload(true);
    },

    sortAction: function(sortCondition) {
      this.set('sortName', sortCondition.get('sortName'));
      this.set('sortDirect', sortCondition.get('sortDirect'));
    }
  }
});
