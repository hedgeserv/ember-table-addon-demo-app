import Ember from 'ember';
import AccountColumnsMixin from '../mixins/account-columns-mixin';
import TableContentMixin from '../mixins/table-content-mixin';
import TableFeatures from '../mixins/features';

export default Ember.Controller.extend(AccountColumnsMixin, TableContentMixin, TableFeatures, {
  rowLoadingIndicatorViewName: 'custom-row-loading-indicator',
  title: 'Row Loading Indicator'
});
