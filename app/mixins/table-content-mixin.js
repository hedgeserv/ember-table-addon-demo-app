import Ember from 'ember';

export default Ember.Mixin.create({
  tableContent: Ember.computed(function () {
    return this.get('model');
  }).property('model'),

  groupMeta: {
    groupingMetadata: [{id: "groupName"}, {id: "groupName"}, {id: "groupName"}]
  }
});
