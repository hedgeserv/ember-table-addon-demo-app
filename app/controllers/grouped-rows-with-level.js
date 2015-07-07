import Ember from 'ember';
import ThreeColumnsMixin from '../mixins/three-columns-mixin';
import TableContentMixin from '../mixins/table-content-mixin';
import GroupedRowIndicatorWithLevel from './../views/grouped-row-indicator-with-level';
export default Ember.Controller.extend(ThreeColumnsMixin, TableContentMixin, {
  indicatorView: GroupedRowIndicatorWithLevel
});
