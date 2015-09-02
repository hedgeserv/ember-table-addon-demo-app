import Ember from 'ember';
import { module, test } from 'qunit';
import AppColumnDefinition from 'ember-table-addon-demo-app/models/app-column-definition';

var column;

module('app column definition', {
  beforeEach: function () {
    column = AppColumnDefinition.create({
      headerCellName: 'Column1',
      dataType: null,
      contentPath: "col"
    });
    column.toggleSortState();
  },

  afterEach: function () {
    column = null;
  }
});

test('sort column when content value type is decimal', function (assert) {
  column.dataType = "decimal";
  assert.equal(column.sortFn({col: "15.27"}, {col: "15.28"}), -1, "‘15.27’ should be smaller than ‘15.28’");
});

test('sort column when content value type is decimal', function (assert) {
  column.dataType = "decimal";
  assert.equal(column.sortFn({col: "3"}, {col: "12"}), -1, "‘3’ should be smaller than ‘12’");
});

test('sort column when content value type is string', function (assert) {
  column.dataType = "string";
  assert.equal(column.sortFn({col: "ember"}, {col: "table"}), -1, "‘ember’ should be smaller than ‘table’");
});

test('sort column when content value type is datetime', function (assert) {
  column.dataType = "datetime";
  assert.equal(column.sortFn({col: "2015-07-28T03:10:05.001Z"}, {col: "2015-07-28T03:10:05.002Z"}), -1, "‘2015-07-28T03:10:05.001Z’ is smaller than ‘2015-07-28T03:10:05.002Z’");
});
