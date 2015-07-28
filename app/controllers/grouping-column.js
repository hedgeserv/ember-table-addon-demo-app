import Ember from 'ember';
import ThreeColumnsMixin from '../mixins/three-columns-mixin';
import TableContentMixin from '../mixins/table-content-mixin';

export default Ember.Controller.extend(ThreeColumnsMixin, TableContentMixin, {
  groupingMetadata: [{id: "groupName"}, {id: "groupName"}, {id: "groupName"}],

  columnsMetadata: [
    ["id", "Id", 20],
    ["activity", "Activity", 150],
    ["status", "status", 150],
    ["use", "Use", 150],
    ["sector", "Sector", 150]
  ]
});
