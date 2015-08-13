import Ember from 'ember';
/*
 * Setup callback to run specific jQuery setup logic.
 * Subclasses can override afterRenderEvent to plug in jQuery code.
 */
export default Ember.View.reopen({
  didInsertElement: function () {
    Ember.run.scheduleOnce('afterRender', this, this.afterRenderEvent);
  },

  afterRenderEvent: Ember.K
});
