import DS from 'ember-data';
import LoanData from '../datasets/loanddata-page1';

let Loan = DS.Model.extend({
  activity: DS.attr(),
  status: DS.attr(),
  sector: DS.attr(),
  repayment_interval: DS.attr(),
  repayment_term: DS.attr()
});

Loan.reopenClass({
  FIXTURES: LoanData.loans
});
export default Loan;
