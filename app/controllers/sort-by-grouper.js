import Ember from 'ember';
import AccountColumnsMixin from '../mixins/account-columns-mixin';
import TableFeatures from '../mixins/features';

export default Ember.Controller.extend(AccountColumnsMixin, TableFeatures, {
  tableContent: [],
  title: "Sort by groupers",
  groupingMetadata: Ember.computed.oneWay('model.groupingMetadata'),

  actions: {
    sortGrouper: function(grouper) {
      var states = ['asc', 'desc', undefined];
      var oldState = Ember.get(grouper, 'sortDirection');
      var index = states.indexOf(oldState) + 1;
      Ember.set(grouper, 'sortDirection', states[index % 3]);
    }
  }
});
