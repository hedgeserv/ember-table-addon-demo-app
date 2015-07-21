import Ember from 'ember';
import ColumnDefinition from 'ember-table/models/column-definition';
import LazyArray from 'ember-table/models/lazy-array';
import ThreeColumnsMixin from '../mixins/three-columns-mixin';
export default Ember.Controller.extend(ThreeColumnsMixin, {

  queryParams:['totalCount'],
  totalCount:100,
  sortName: null,
  sortDirect: null,

  model: function () {
    var self = this;
    var totalCount = this.get('totalCount');
    return LazyArray.create({
      chunkSize: 50,
      totalCount: 200,
      callback: function (pageIndex, query) {
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
