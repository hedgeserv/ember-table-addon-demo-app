import Ember from 'ember';
import TableFeatures from '../mixins/features';
import TreeDataGridMixin from '../mixins/tree-data-grid';

export default Ember.Controller.extend(TableFeatures, TreeDataGridMixin, {
  tableContent: [],
  title: "Tree Data",
  features: [
    {
      name: 'Lazy Loading',
      icon: 'fa-flash'
    },
    {
      name: 'Column Group',
      icon: 'fa-arrows-v'
    },
    {
      name: 'Sort',
      icon: 'fa-sort'
    }
  ]
});
