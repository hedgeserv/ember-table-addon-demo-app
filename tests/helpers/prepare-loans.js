import Ember from 'ember';
import mb from './mountebank-util';

export default Ember.Test.registerAsyncHelper('prepareLoans',
  function(app, count) {
    var loans = [];
    for (var i = 0; i < count; i++) {
      loans.push({
        "id": i,
        "activity": "activity " + i,
        "status": "status " + i
      });
    }
    var body = {
      "header": {
        "page": 1
      },
      "loans": loans
    };
    return mb.stubForOne("GET", "/loans", body);
});
