import Ember from "ember";
import { module, test } from 'qunit';
import LazyArray from '../../../models/lazy-array';

var loadedCount = 0;
function getNextChunk() {
  var chunk = [];
  for(var i = 0; i < 100; i++){
    chunk.push({
      id: i + loadedCount
    });
  }

  loadedCount += 100;
  return chunk;
}

var totalCount = 200;
var initSize = 100;

var lazyArray;

module('Given a lazy array with total count 200 and init size 100, and Chunk size is 100', {
  beforeEach: function() {
    loadedCount = 0;
    lazyArray = new LazyArray(totalCount, initSize, getNextChunk);
  },
  afterEach: function() {
    lazyArray = null;
  }
});

test('Should load next 100 loans When accessing the 90th loans', function(assert) {
  assert.equal(loadedCount, 100);

  lazyArray.objectAt(89);

  assert.equal(loadedCount, 200);
});

test('Should not load next 100 loans When accessing the 89th loans', function(assert) {
  assert.equal(loadedCount, 100);

  lazyArray.objectAt(88);

  assert.equal(loadedCount, 100);
});

test('Should return the 5th loan When accessing the 5th loan ', function(assert) {
  assert.equal(lazyArray.objectAt(4).id, 4);
});

test('Should return the 101th loan When accessing the 101th loan ', function(assert) {
  assert.equal(lazyArray.objectAt(100).id, 100);
});

test('Should return length of 200', function(assert) {
  assert.equal(lazyArray.length, 200);
});

test('Should be instance of Ember.ArrayProxy', function(assert) {
  assert.ok(lazyArray.toString().indexOf("Ember.ArrayProxy") >= 0);
});
