import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

export default Router.map(function() {
  this.route('loans');
  this.route('fullyLoadedLoans', {path: '/fully-loaded-loans'});
  this.route('lazyLoadedLoans', {path: '/lazy-loaded-loans'});
});
