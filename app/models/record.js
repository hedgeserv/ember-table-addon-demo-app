import Ember from 'ember';
import DS from 'ember-data';

let Record = DS.Model.extend({
  glAccountSection: DS.attr('string'),
  glAccountType: DS.attr('string'),
  glAccountCode: DS.attr('string'),
  glAccountDescription: DS.attr('string'),
  beginningDr: DS.attr('number'),
  beginningCr: DS.attr('number'),
  netBeginning: DS.attr('number'),
  activityDr: DS.attr('number'),
  activityCr: DS.attr('number'),
  netActivity: DS.attr('number'),
  endingDr: DS.attr('number'),
  endingCr: DS.attr('number'),
  netEnding: DS.attr('number'),
  children: DS.hasMany('record', {inverse: null}),
  isGroupRow: Ember.computed(function () {
    var children = this.get('children');
    return children && children.length > 0;
  }).property('children')
});

export default Record;
