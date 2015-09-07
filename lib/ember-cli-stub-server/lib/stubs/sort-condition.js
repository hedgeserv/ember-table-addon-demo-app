var helper = require('./helper')

var SortCondition = function (sortNames, sortDirects) {
  this.sortNames = sortNames;
  this.sortDirects = sortDirects;
};

SortCondition.prototype.toQuery = function (){
	var self = this;
	return this.sortNames.reduce(function(res, sortName, index){
    res['sortNames['+index+']'] = sortName;
    res['sortDirects['+index+']'] = self.sortDirects[index];
    return res;
  }, {});
};

SortCondition.prototype.sort = function(data){
  if(this.sortNames.length < 1){
    return data.slice();
  }
	var sortStatesMap = {'asc': 1, 'desc': -1};
	var self = this;
  var sortFn = function (prev, next) {
    for (var i = 0; i < self.sortNames.length; i++) {
    	var sortDirect = self.sortDirects[i];
    	var sortName = self.sortNames[i];
      var sortState = sortStatesMap[sortDirect];
      var singleColumnCompareResult = sortState * helper.compare(prev, next, sortName);
      if (singleColumnCompareResult !== 0) {
        return singleColumnCompareResult;
      }
    }
    return 0;
  };
  return data.slice().sort(sortFn);
};

module.exports = SortCondition;
