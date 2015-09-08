var helper = require('./helper');
var SortCondition = require('./sort-condition')
var sortDirects = ['asc', 'desc'];

var SortConditionProvider = function (columns){
  this.sortColumns =  columns || [];
};

SortConditionProvider.prototype.forEach = function (callBack) {
  var namesArr = this.productNames();
  var self = this;
  namesArr.forEach(function (names) {
    self.mapDirects(names).forEach(function (directs) {
      callBack(new SortCondition(names, directs));
    });
  });
};

SortConditionProvider.prototype.productNames = function () {
  var result = [];
  var self = this;
  this.sortColumns.forEach(function() {
    result = result.concat(self.product(result, self.sortColumns, true));
  });
  return helper.uniq(result);
};

SortConditionProvider.prototype.mapDirects = function (names) {
  var sortDirects = ['asc', 'desc'];
  var allDirects = [];
  var self = this;
  names.forEach(function () {
    allDirects = self.product(allDirects, sortDirects);
  });
  return allDirects;
};


SortConditionProvider.prototype.product = function (firstArr, secondArr, uniq) {
  if(firstArr.length === 0){
    return secondArr.map(function (item) {
      return [item];
    });
  }
  var result = [];
  firstArr.forEach(function (first) {
    secondArr.forEach(function (second) {
      var item = first.slice();
      if(!uniq || item.indexOf(second) === -1){
        item.push(second);
        result.push(item);
      }
    });
  });
  return result;
};





module.exports = SortConditionProvider;
