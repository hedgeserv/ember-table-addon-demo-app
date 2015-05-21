import Ember from 'ember';

export default Ember.Route.extend({

  setupController: function(controller){
    //controller.set('totalCount',this.get('params').totalCount);
  },

  beforeModel: function(transition){
    //this.set('params', transition.queryParams);
  }
});
