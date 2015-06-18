import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

export default Router.map(function() {
  this.route('fullyLoadedLoans', {path: '/fully-loaded-loans'});
  this.route('lazyLoadedLoans', {path: '/lazy-loaded-loans'});
  this.route('groups');
  this.route('groupsReorder',{path: '/groups-reorder'});
  this.route('groupsSort',{path: '/groups-sort'});
  this.route('groupingColumn', {path: 'grouping-column'});
  this.route('groupingColumnAndFixed', {path: 'grouping-column-and-fixed'});
  this.route('groupedRows', {path: 'grouped-rows'});
  this.route('groupedRowsWithLevel', {path: 'grouped-rows-with-level'});
});
