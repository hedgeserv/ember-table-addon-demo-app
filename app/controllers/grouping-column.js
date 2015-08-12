import Ember from 'ember';
import ThreeColumnsMixin from '../mixins/three-columns-mixin';
import TableContentMixin from '../mixins/table-content-mixin';
import TableFeatures from '../mixins/features';

export default Ember.Controller.extend(ThreeColumnsMixin, TableContentMixin, TableFeatures, {
	title: 'GroupingColumn',

  groupingMetadata: [{id: "groupName"}, {id: "groupName"}, {id: "groupName"}],

  columnsMetadata: [
    ["id", "Id", 60],
    ["activity", "Activity", 150],
    ["status", "status", 150],
    ["use", "Use", 150],
    ["sector", "Sector", 150]
  ]
});
