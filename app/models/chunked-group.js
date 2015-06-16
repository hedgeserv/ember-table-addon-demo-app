import Ember from 'ember';
import DS from 'ember-data';

let ChunkedGroup = DS.Model.extend({
  children: DS.hasMany('chunkedGroup', {inverse: null}),
  isGroupRow: Ember.computed(function () {
    var children = this.get('children');
    return children && children.length > 0;
  }).property('children')

});

export default ChunkedGroup;
