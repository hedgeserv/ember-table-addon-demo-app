import Ember from 'ember';

export default Ember.Route.extend({
  model: function () {
    var dataStore = this.store;
    var promises = [1, 2, 3, 4, 5, 6, 7].map(function(pageIndex) {
      return dataStore.find('loan', {
        page: pageIndex
      });
    });

    return Ember.RSVP.all(promises).then(function(pages) {
      return pages.reduce(function (previous, current) {
        var startRowNumber = previous.length;
        var loans = current.map(function (loan, index) {
          loan.rowNumber = (1 + index) + startRowNumber;
          return loan;
        });
        return previous.concat(loans);
      }, []);
    });
  }
});
