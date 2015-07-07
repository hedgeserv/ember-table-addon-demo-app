import Ember from 'ember';
import AccountColumnsMixin from '../mixins/account-columns-mixin';
import TableContentMixin from '../mixins/table-content-mixin';

export default Ember.Controller.extend(TableContentMixin, AccountColumnsMixin, {});
