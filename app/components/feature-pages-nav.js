import Ember from 'ember';

export default Ember.Component.extend({
  afterRenderEvent: function () {
    this.initAffixMenu();
  },

  initAffixMenu: function () {
    if (this.$(".affix-menu").length > 0) {
      var self = this;
      Ember.run.later(function () {
        var $sideBar = self.$();
        $sideBar.affix({
          offset: {
            top: function () {
              var offsetTop = $sideBar.offset().top;
              return (this.top = offsetTop - 65);
            },
            bottom: function () {
              var affixBottom = Ember.$(".footer").outerHeight(true) + Ember.$(".subfooter").outerHeight(true);
              if (self.$(".footer-top").length > 0) {
                affixBottom = affixBottom + self.$(".footer-top").outerHeight(true);
              }
              return (this.bottom = affixBottom + 50);
            }
          }
        });
      }, 100);
    }
  },

  scrollSpy: function () {
    if(this.$(".scrollspy").length>0) {
      Ember.$("body").addClass("scroll-spy");
      if(Ember.$(".fixed.header").length>0) {
        Ember.$('body').scrollspy({
          target: '.scrollspy',
          offset: 85
        });
      } else {
        Ember.$('body').scrollspy({
          target: '.scrollspy',
          offset: 20
        });
      }
    }

  }
});
