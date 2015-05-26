import DS from 'ember-data';

let Loan = DS.Model.extend({
  activity: DS.attr(),
  status: DS.attr(),
  sector: DS.attr(),
  name: DS.attr(),
  use: DS.attr()
});

export default Loan;
