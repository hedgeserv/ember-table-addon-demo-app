import Ember from 'ember';
import ThreeColumnsMixin from '../mixins/three-columns-mixin';
import TableContentMixin from '../mixins/table-content-mixin';
import TableFeatures from '../mixins/features';

export default Ember.Controller.extend(ThreeColumnsMixin, TableContentMixin, TableFeatures, {
  indicatorViewName: 'grouped-row-indicator-with-level',
  title: 'Custom Group Indicator'
});
