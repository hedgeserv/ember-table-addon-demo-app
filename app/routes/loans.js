import Ember from 'ember';

export default Ember.Route.extend({
  model: function () {
    var dataStore = this.store;
    var pageIndexes = new Array(70);
    for(var i=0; i<pageIndexes.length; i++) {
      pageIndexes[i] = i+1;
    }
    var promises = pageIndexes.map(function(pageIndex) {
      return dataStore.find('loan', {
        page: pageIndex
      });
    });

    return Ember.RSVP.all(promises).then(function(pages) {
      return pages.reduce(function (previous, current) {
        return previous.concat(current.toArray());
      }, Ember.A([]));
    });
  }
});
