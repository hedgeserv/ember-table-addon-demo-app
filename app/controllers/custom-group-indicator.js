import Ember from 'ember';
import ThreeColumnsMixin from '../mixins/three-columns-mixin';
import TableContentMixin from '../mixins/table-content-mixin';
import GroupedRowIndicatorWithLevel from './../views/grouped-row-indicator-with-level';
import TableFeatures from '../mixins/features';

export default Ember.Controller.extend(ThreeColumnsMixin, TableContentMixin, TableFeatures, {
  indicatorView: GroupedRowIndicatorWithLevel,
  title: 'Custom Group Indicator'
});
