
import Ember from 'ember';

export default function (totalCount, initSize, getNextChunk) {
  var ret = getNextChunk();

  var LazyArray = Ember.ArrayProxy.extend({
    objectAt: function(index) {
      var current = [];
      if(index >= 89) {
        current = getNextChunk();
      }
      ret = ret.concat(current);

      return ret[index];
    },
    contentArrayDidChange: function() {
      console.log("contentArrayDidChange");
    },
    contentArrayWillChange: function() {
      console.log("contentArrayWillChange");
    },
    replaceContent: function() {
      console.log("replaceContent");
    },
    length: totalCount
  });

  return LazyArray.create({
    content: Ember.A(new Array(totalCount))
  });
}
