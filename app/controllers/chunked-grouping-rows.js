import Ember from 'ember';
import AccountColumnsMixin from '../mixins/account-columns-mixin';
import TableFeatures from '../mixins/features';

export default Ember.Controller.extend(AccountColumnsMixin, TableFeatures, {
  tableContent: [],
  title: "Chunked Grouping column"
});
