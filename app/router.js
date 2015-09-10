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
  this.route('customGroupIndicator', {path: 'custom-group-indicator'});
  this.route('chunkedGroupingRows', {path: 'chunked-grouping-rows'});
  this.route('groupedRowLoadingIndicator', {path: 'grouped-row-loading-indicator'});
  this.route('grandTotalRow', {path: 'grand-total-row'});
  this.route('groupedRowsErrorHandling', {path: 'grouped-rows-error-handling'});
  this.route('sortByGrouper', {path: 'sort-by-grouper'});
  this.route('arrayData', {path: 'array-data'});
});
