import Ember from 'ember';
import TableFeatures from '../mixins/features';
import TreeDataGridMixin from '../mixins/tree-data-grid';

export default Ember.Controller.extend(TableFeatures, TreeDataGridMixin, {
  tableContent: [],
  title: "Style Customization",
  features: [
    {
      name: 'Column Group Headers',
      icon: 'fa-flash'
    },
    {
      name: 'Sorting Indicator',
      icon: 'fa-arrows-v'
    },
    {
      name: 'Group Row Indicator',
      icon: 'fa-sort'
    }
  ],

  getColumnGroupStyles: function () {
    return {
      cellStyle: "text-red",
      innerColumnStyle: "text-blue",
      firstColumnStyle: "bg-gray",
      lastColumnStyle: "bg-lightgray",
      groupStyle: "text-center"
    };
  }

});
