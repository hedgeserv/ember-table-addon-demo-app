function decorate (request, response, logger) {
  var _hidden = response.headers['_hidden'];
  var dirName = _hidden['dirName'];
  var SortCondition = require(dirName + "/sort-condition");
  var sortNameMap = _hidden['sortNameMap'];
  require(dirName + '/sort-and-chunk-decorator')(request, response, SortCondition, sortNameMap);
}
