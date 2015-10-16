import Ember from 'ember';

export default Ember.Component.extend({
  afterRenderEvent: function () {
    this.initAffixMenu();
    this.addPreventAffixedListener();
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
            }
          }
        });
      }, 100);
    }
  },

  addPreventAffixedListener: function() {
    let $sideBar = this.$();
    $sideBar.on('affix.bs.affix', function (event) {
      // prevent `$sideBar` fixed when shrinking page.
      if (Ember.$('.main').offset().top !== $sideBar.offset().top) {
        event.preventDefault();
      }
    });
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
