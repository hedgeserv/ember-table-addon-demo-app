import Ember from 'ember';

export default Ember.Component.extend({
  afterRenderEvent: function () {
    //Owl carousel
    //-----------------------------------------------
    this.$(".owl-carousel.carousel").owlCarousel({
      items: 4,
      pagination: false,
      navigation: true,
      navigationText: false
    });

    // Animations
    //-----------------------------------------------
    var Modernizr = window.Modernizr;
    if ((Ember.$("[data-animation-effect]").length>0) && !Modernizr.touch) {
      Ember.$("[data-animation-effect]").each(function() {
        var item = Ember.$(this),
          animationEffect = item.attr("data-animation-effect");

        if(Modernizr.mq('only all and (min-width: 768px)') && Modernizr.csstransitions) {
          item.appear(function() {
            if (item.attr("data-effect-delay")) {
              item.css("effect-delay", "0ms");
            }
            setTimeout(function() {
              item.addClass('animated object-visible ' + animationEffect);

            }, item.attr("data-effect-delay"));
          }, {accX: 0, accY: -130});
        } else {
          item.addClass('object-visible');
        }
      });
    }
  }
});
