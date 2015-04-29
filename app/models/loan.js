import DS from 'ember-data';
import Page1 from '../datasets/loandata-page1';

let Loan = DS.Model.extend({
  activity: DS.attr(),
  status: DS.attr(),
  sector: DS.attr(),
  repayment_interval: DS.attr(),
  repayment_term: DS.attr()
});

Loan.reopenClass({
  FIXTURES: Page1.loans
});
export default Loan;
