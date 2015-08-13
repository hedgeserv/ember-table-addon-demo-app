var Funnel = require('broccoli-funnel');
var path = require('path');
var mergeTrees = require('broccoli-merge-trees');

module.exports = {
  name: 'bootstrap-idea',

  isDevelopingAddon: function () {
    return true;
  },

  included: function (app) {
    // bower packages
    app.import(app.bowerDirectory + '/isotope/dist/isotope.pkgd.js');
    app.import(app.bowerDirectory + '/bootstrap/dist/css/bootstrap.css');
    app.import(app.bowerDirectory + '/bootstrap/dist/js/bootstrap.js');
    app.import(app.bowerDirectory + '/magnific-popup/dist/jquery.magnific-popup.js');
    app.import(app.bowerDirectory + '/magnific-popup/dist/magnific-popup.css');
    app.import(app.bowerDirectory + '/jquery.parallax/jquery.parallax.js');

    // content slider
    app.import(app.bowerDirectory + '/modernizr/modernizr.js');
    app.import(app.bowerDirectory + '/owl-carousel/owl-carousel/owl.carousel.js');
    app.import(app.bowerDirectory + '/owl-carousel/owl-carousel/owl.carousel.css');

    app.import('vendor/plugins/jquery.appear.js');

    // rs-plugin
    app.import('vendor/plugins/rs-plugin/js/jquery.themepunch.tools.min.js');
    app.import('vendor/plugins/rs-plugin/js/jquery.themepunch.revolution.min.js');
    app.import('vendor/plugins/rs-plugin/css/extralayers.css');
    app.import('vendor/plugins/rs-plugin/css/settings.css'); //hack: before css/skins/red.css
    app.import('vendor/plugins/rs-plugin/css/settings-ie8.css');

    // fonts
    app.import('vendor/fonts/font-awesome/css/font-awesome.css');
    app.import('vendor/fonts/fontello/css/fontello.css');

    // styles
    app.import('vendor/css/animate.css');
    app.import('vendor/css/animations.css');
    app.import('vendor/css/custom.css');
    app.import('vendor/css/style.css');
    app.import('vendor/css/skins/red.css');

    // template js
    app.import('vendor/js/template.js');

  },

  treeForPublic: function () {
    // images
    var imageDir = this.fixDir('vendor/images');
    var images = new Funnel(imageDir, {
      srcDir: '/',
      include: ['*'],
      destDir: '/images'
    });

    var rsImagesDir = this.fixDir('vendor/plugins/rs-plugin/assets');
    var rsImageTree = new Funnel(rsImagesDir, {
      srcDir: '/',
      include: ['*'],
      destDir: '/assets'
    });

    // fonts
    var fontAwesomeDir = this.fixDir('vendor/fonts/font-awesome/fonts');
    var fontAwesome = new Funnel(fontAwesomeDir, {
      srcDir: '/',
      include: ['*'],
      destDir: '/fonts'
    });

    var fontelloDir = this.fixDir('vendor/fonts/fontello/font');
    var fontello = new Funnel(fontelloDir, {
      srcDir: '/',
      include: ['*'],
      destDir: '/font'
    });

    return mergeTrees([rsImageTree, fontAwesome, fontello, images]);
  },

  fixDir: function (dir) {
    return path.join(this.root, dir);
  }
};
