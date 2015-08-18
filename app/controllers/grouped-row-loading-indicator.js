import Ember from 'ember';
import AccountColumnsMixin from '../mixins/account-columns-mixin';
import TableContentMixin from '../mixins/table-content-mixin';
import CustomRowLoadingIndicator from './../views/custom-row-loading-indicator';
import TableFeatures from '../mixins/features';

export default Ember.Controller.extend(AccountColumnsMixin, TableContentMixin, TableFeatures, {
  rowLoadingIndicatorView: CustomRowLoadingIndicator,
  title: 'Row Loading Indicator'
});
