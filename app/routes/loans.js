import Ember from 'ember';
import DS from 'ember-data';

export default Ember.Route.extend({
  model: function () {
    var promises = [1, 2, 3, 4, 5, 6, 7].map(function(id){
      return Ember.$.getJSON("http://localhost:5555/loans?page=" + id);
    });
    return Ember.RSVP.all(promises).then(function(loansArrays) {
      return loansArrays.reduce(function(previous, current) {
        var loans = current.loans.map(function(loan, index) {
          loan.rowNumber = (1 + index) + (current.header.page - 1) * current.header.page_size;
          return loan;
        });
        return previous.concat(loans);
      }, []);
    });
  }
});
