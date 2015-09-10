import Ember from 'ember';

export default Ember.Mixin.create({
  _tables: [{
    name: "Tree Data",
    description: "sort group data by groupers and columns",
    link: "treeData"
  },{
    name: "Array Data",
    description: "this is a faster experience for the end user because of lazy loading.",
    link: "arrayData"
  }, {
    name: "Style Customization",
    description: '',
    link: "styleCustomization"
  }],

  tables: Ember.computed.filter('_tables', function (table, index) {
    var newTable = Ember.copy(table);
    newTable.labelClass = this.get('title') === table.name ? 'active' : '';
    var delay = index > 4 ? 0 : (4 - index) * 100;
    Ember.set(newTable, 'delay', delay);
    return newTable;
  })
});
