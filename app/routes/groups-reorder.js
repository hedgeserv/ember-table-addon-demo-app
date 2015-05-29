import Ember from 'ember';

export default Ember.Route.extend({
  model: function() {
    return this.store.find('loan', {section: 1});
  },

  setUpController: function(controller, model){
    controller.set('content', model);
  }

});
