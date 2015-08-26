function (request, response, logger) {
  var SortCondition = require("%s/sort-condition");
  var section = request.query.section;
  var resBody = JSON.parse(response.body);
  var meta = resBody.meta || {}
  var resourceName = 'loans' in resBody ? 'loans' : 'chunkedGroups'
  var body = resBody[resourceName] || [];
  if(!!meta.totalCount){
    body = body.slice(0, meta.totalCount);
  }
  var sorts = ['sortNames', 'sortDirects'].map(function (name) {
    return getSortItem(request.query, name);
  });

  var sortNameMap = %s;
  var sortNames = sorts[0].map(function (name) {
    return sortNameMap[name] || name;
  });
  var sortCondition = new SortCondition(sortNames, sorts[1]);
  var sortedBody = sortCondition.sort(body);
  var data = !!section ? getChunkOf(sortedBody, section, meta.pageSize) : sortedBody;
  meta.page = section;
  var result = {meta: meta}
  result[resourceName] = data

  response.body = JSON.stringify(result);

  // private method
  function getChunkOf(body, idx, chunkSize) {
    var startIndex = (idx - 1) * chunkSize;
    return body.slice(startIndex, chunkSize + startIndex);
  };

  function getSortItem(conditions, name) {
    var sortKeys = [];
    for (var key in conditions) {
      if (key.match(name)) {
        sortKeys.push(key)
      }
    }
    return sortKeys.sort().map(function (key) {
      return conditions[key];
    });
  }
}
