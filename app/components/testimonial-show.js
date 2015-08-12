import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['owl-carousel', 'content-slider'],

  afterRenderEvent: function () {
    this.$().owlCarousel({
      singleItem: true,
      autoPlay: 5000,
      navigation: false,
      navigationText: false,
      pagination: false
    });
  }
});
