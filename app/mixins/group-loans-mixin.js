import Ember from 'ember';

export default Ember.Mixin.create({
  model: function() {
    return this.store.find('loan', {
      group: true
    });
  }
});
