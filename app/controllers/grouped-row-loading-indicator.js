import Ember from 'ember';
import AccountColumnsMixin from '../mixins/account-columns-mixin';
import TableContentMixin from '../mixins/table-content-mixin';
import CustomRowLoadingIndicator from './../views/custom-row-loading-indicator';


export default Ember.Controller.extend(AccountColumnsMixin, TableContentMixin, {
  rowLoadingIndicatorView: CustomRowLoadingIndicator
});
