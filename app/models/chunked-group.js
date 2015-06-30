import DS from 'ember-data';

let ChunkedGroup = DS.Model.extend({
  accountSection: DS.attr('string'),
  accountType: DS.attr('string'),
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
  children: DS.hasMany('chunkedGroup', {inverse: null})
});

export default ChunkedGroup;
