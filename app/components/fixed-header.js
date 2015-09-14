import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['header', 'fixed', 'clearfix'],
  tagName: 'header',

  afterRenderEvent: function() {
    // Ignore '$ undefined warning'
    /* jshint ignore:start */
    var	headerTopHeight = this.$(".header-top").outerHeight();
    var headerHeight = this.$().outerHeight();
    Ember.$(window).scroll(function() {
      if(($(this).scrollTop() > headerTopHeight+headerHeight) && ($(window).width() > 767)) {
        $("body").addClass("fixed-header-on");
        $(".header.fixed").addClass('animated object-visible fadeInDown');
        if (!($(".header.transparent").length>0)) {
          if ($(".banner:not(.header-top)").length>0) {
            $(".banner").css("marginTop", (headerHeight)+"px");
          } else if ($(".page-intro").length>0) {
            $(".page-intro").css("marginTop", (headerHeight)+"px");
          } else if ($(".page-top").length>0) {
            $(".page-top").css("marginTop", (headerHeight)+"px");
          } else {
            $("section.main-container").css("marginTop", (headerHeight)+"px");
          }
        }
      } else {
        $("body").removeClass("fixed-header-on");
        $("section.main-container").css("marginTop", (0)+"px");
        $(".banner").css("marginTop", (0)+"px");
        $(".page-intro").css("marginTop", (0)+"px");
        $(".page-top").css("marginTop", (0)+"px");
        $(".header.fixed").removeClass('animated object-visible fadeInDown');
      }
    });
    /* jshint ignore:end */
  }
});
