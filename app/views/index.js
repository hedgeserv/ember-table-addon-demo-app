import Ember from 'ember';
import TablesMixin from '../mixins/features';

export default Ember.View.extend(TablesMixin, {
  afterRenderEvent: function () {

    //Revolution Slider
    if (Ember.$(".slider-banner-container").length > 0) {

      Ember.$(".tp-bannertimer").show();
      var defaultOptions = Ember.Object.create({
        delay: 10000,
        startwidth: 1140,
        startheight: 520,

        navigationArrows: "solo",

        navigationStyle: "round",
        navigationHAlign: "center",
        navigationVAlign: "bottom",
        navigationHOffset: 0,
        navigationVOffset: 20,

        soloArrowLeftHalign: "left",
        soloArrowLeftValign: "center",
        soloArrowLeftHOffset: 20,
        soloArrowLeftVOffset: 0,

        soloArrowRightHalign: "right",
        soloArrowRightValign: "center",
        soloArrowRightHOffset: 20,
        soloArrowRightVOffset: 0,

        fullWidth: "on",

        spinner: "spinner0",

        stopLoop: "off",
        stopAfterLoops: -1,
        stopAtSlide: -1,
        onHoverStop: "off",

        shuffle: "off",

        autoHeight: "off",
        forceFullWidth: "off",

        hideThumbsOnMobile: "off",
        hideNavDelayOnMobile: 1500,
        hideBulletsOnMobile: "off",
        hideArrowsOnMobile: "off",
        hideThumbsUnderResolution: 0,

        hideSliderAtLimit: 0,
        hideCaptionAtLimit: 0,
        hideAllCaptionAtLimit: 0,
        startWithSlide: 0
      });

      var sliders = [
        {
          selector: '.slider-banner',
          options: {}
        },
        {
          selector: '.slider-banner-2',
          options: {
            navigationStyle: "preview4"
          }
        },
        {
          selector: '.slider-banner-2',
          options: {
            navigationStyle: "preview5",
            parallax: "mouse",
            parallaxBgFreeze: "on",
            parallaxLevels: [3, 2, 1]
          }
        }
      ];

      sliders.forEach(function(s) {
        var options = Ember.Object.create(defaultOptions).setProperties(s.options);
        Ember.$('.slider-banner-container')
          .find(s.selector)
          .show()
          .revolution(options);
      });
    }

    //Owl carousel
    //-----------------------------------------------
    if (Ember.$('.owl-carousel').length > 0) {
      Ember.$(".owl-carousel.carousel").owlCarousel({
        items: 4,
        pagination: false,
        navigation: true,
        navigationText: false
      });
      Ember.$(".owl-carousel.content-slider").owlCarousel({
        singleItem: true,
        autoPlay: 5000,
        navigation: false,
        navigationText: false,
        pagination: false
      });
    }

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
