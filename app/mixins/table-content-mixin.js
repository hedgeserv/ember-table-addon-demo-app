import Ember from 'ember';

export default Ember.Mixin.create({
  tableContent: Ember.computed(function () {
    return Ember.ArrayProxy.create({
      content: this.get('model'),
      groupingMetadata: this.get('groupingMetadata')
    });
  }).property('model'),
  groupingMetadata: [{id: "groupName"}, {id: "groupName"}, {id: "groupName"}]
});
