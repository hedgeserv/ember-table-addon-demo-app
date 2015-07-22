import Ember from 'ember';
import ChunkedGroupDataMixin from '../mixins/chunked-group-data-mixin';
import SortQueryMixin from '../mixins/sort-query-mixin';

export default Ember.Route.extend(ChunkedGroupDataMixin, SortQueryMixin, { });
