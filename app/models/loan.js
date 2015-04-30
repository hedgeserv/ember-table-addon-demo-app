import DS from 'ember-data';

let Loan = DS.Model.extend({
  activity: DS.attr(),
  status: DS.attr(),
  sector: DS.attr(),
  repayment_interval: DS.attr(),
  repayment_term: DS.attr()
});

export default Loan;
