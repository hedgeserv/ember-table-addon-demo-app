import Ember from 'ember';

export default Ember.Mixin.create({
  _tables: [{
    name: "Sort By Groupers",
    description: "sort group data by groupers and columns",
    link: "sortByGrouper"
  },{
    name: "Lazy Loaded Loans",
    description: "this is a faster experience for the end user because of lazy loading.",
    link: "lazyLoadedLoans"
  }, {
    name: "Column Groups",
    description: '',
    link: "groups"
  }, {
    name: "Column Groups Reorder",
    link: "groupsReorder",
    description: ""
  }, {
    name: "Column Groups Sort inner column",
    description: "",
    link: "groupsSort"
  }, {
    name: "Grouping Column",
    description: "",
    link: "groupingColumn"
  }, {
    name: "Grouping Column And Fixed Columns",
    description: "",
    link: "groupingColumnAndFixed"
  }, {
    name: "Custom Group Indicator",
    description: "",
    link: "customGroupIndicator"
  }, {
    name: "Chunked Grouping Rows",
    description: "",
    link: "chunkedGroupingRows"
  }, {
    name: "Rows with loading indicator",
    description: "",
    link: "groupedRowLoadingIndicator"
  }, {
    name: "Grand total Row",
    description: "",
    link: "grandTotalRow"
  }, {
    name: "Grouped rows Error handling",
    link: "groupedRowsErrorHandling"
  }, {
    name: "Fully Loaded Loans",
    description: "this is a vanilla usage of Ember Table that is slow to load because of a large dataset.i.e.expect this page to load slowly ",
    link: 'fullyLoadedLoans'
  }],

  tables: Ember.computed.filter('_tables', function (table, index) {
    var newTable = Ember.copy(table);
    newTable.labelClass = this.get('title') === table.name ? 'active' : '';
    var delay = index > 4 ? 0 : (4 - index) * 100;
    Ember.set(newTable, 'delay', delay);
    return newTable;
  })
});
