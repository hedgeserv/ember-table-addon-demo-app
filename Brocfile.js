/* global require, module */
var Funnel = require('broccoli-funnel');
var EmberApp = require('ember-cli/lib/broccoli/ember-app');
var mergeTrees = require('broccoli-merge-trees');

var app = new EmberApp();

// bower packages
app.import(app.bowerDirectory + '/isotope/dist/isotope.pkgd.js');
app.import(app.bowerDirectory + '/bootstrap/dist/css/bootstrap.css');
app.import(app.bowerDirectory + '/bootstrap/dist/js/bootstrap.js');
app.import(app.bowerDirectory + '/magnific-popup/dist/jquery.magnific-popup.js');
app.import(app.bowerDirectory + '/magnific-popup/dist/magnific-popup.css');

// slider shows
// TODO: use bower package
app.import('vendor/plugins/rs-plugin/js/jquery.themepunch.tools.min.js');
app.import('vendor/plugins/rs-plugin/js/jquery.themepunch.revolution.min.js');
app.import('vendor/plugins/rs-plugin/css/extralayers.css');
app.import('vendor/plugins/rs-plugin/css/settings.css'); //hack: before css/skins/red.css
app.import('vendor/plugins/rs-plugin/css/settings-ie8.css');
app.import(app.bowerDirectory + '/jquery.parallax/jquery.parallax.js');

// content slider
app.import(app.bowerDirectory + '/modernizr/modernizr.js');
app.import(app.bowerDirectory + '/owl-carousel/owl-carousel/owl.carousel.js');
app.import(app.bowerDirectory + '/owl-carousel/owl-carousel/owl.carousel.css');
// TODO: use bower package
app.import('vendor/plugins/jquery.appear.js');

// styles
app.import('vendor/css/animate.css');
app.import('vendor/css/animations.css');
app.import('vendor/css/custom.css');
app.import('vendor/css/style.css');
app.import('vendor/css/skins/red.css');

// fonts
app.import('vendor/fonts/font-awesome/css/font-awesome.css');
app.import('vendor/fonts/fontello/css/fontello.css');


// template js
app.import('vendor/js/template.js');

// fonts
var fontAwesome = new Funnel('vendor/fonts/font-awesome/fonts', {
   srcDir: '/',
   include: ['*'],
   destDir: '/fonts'
});

var fontello = new Funnel('vendor/fonts/fontello/font', {
   srcDir: '/',
   include: ['*'],
   destDir: '/font'
});

// images
var rsImages = new Funnel('vendor/plugins/rs-plugin/assets', {
   srcDir: '/',
   include: ['*'],
   destDir: '/assets'
});

var images = new Funnel('vendor/images', {
   srcDir: '/',
   include: ['*'],
   destDir: '/images'
});

var assets = mergeTrees([fontAwesome, images, rsImages, fontello]);
// Use `app.import` to add additional libraries to the generated
// output files.
//
// If you need to use different assets in different
// environments, specify an object as the first parameter. That
// object's keys should be the environment name and the values
// should be the asset to use in that environment.
//
// If the library that you are including contains AMD or ES6
// modules that you would like to import into your application
// please specify an object with the list of modules as keys
// along with the exports of each module as its value.

module.exports = app.toTree(assets);
