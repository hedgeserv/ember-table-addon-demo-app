import Ember from 'ember';
import RowLoadingIndicator from 'ember-table/views/row-loading-indicator';

export default RowLoadingIndicator.extend({
  templateName: 'custom-row-loading-indicator',

  indicatorClass: Ember.computed(function() {
    var classNames = ['custom-row-loading-indicator'];
    if (this.get('isLoading')) {
      classNames.push('loading');
    }
    return classNames.join(' ');
  }).property('isLoading')
});
