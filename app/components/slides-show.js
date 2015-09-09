import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['slideshow'],
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
        startWithSlide: 0,
        hideTimerBar: 'on'
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
          selector: '.slider-banner-3',
          options: {
            navigationStyle: "preview5",
            parallax: "mouse",
            parallaxBgFreeze: "on",
            parallaxLevels: [3, 2, 1]
          }
        }
      ];

      sliders.forEach(function (s) {
        var options = Ember.Object.create(defaultOptions).setProperties(s.options);
        Ember.$('.slider-banner-container')
          .find(s.selector)
          .show()
          .revolution(options);
      });
    }

  },

  willDestroyElement: function() {
    this.disableSliders();
  },

  disableSliders: function () {
    Ember.$('.slider-banner').destroyRevolution();
  }
});
