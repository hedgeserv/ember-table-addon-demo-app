import Ember from 'ember';
import AccountColumnsMixin from '../mixins/account-columns-mixin';

export default Ember.Controller.extend(AccountColumnsMixin, {
  tableContent: []
});
