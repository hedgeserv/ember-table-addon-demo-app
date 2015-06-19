import Ember from 'ember';
import GroupedRowIndicator from 'ember-table/views/grouped-row-indicator';

export default GroupedRowIndicator.extend({
	templateName: 'grouped-row-indicator-with-level',

	classNames: ['custom-grouped-row-indicator'],

	indicatorClass: Ember.computed(function() {
		var isExpanded = this.get('isExpanded');
		return isExpanded ? 'text-red unfold' : 'text-blue fold';
	}).property('isExpanded')

});
