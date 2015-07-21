var helper = require('./helper');
var MBStub = require('./m-b-stub');
var stubs = [];
var i, j, k, iIdx, jIdx, kIdx;

// prepare unsort data
var bodyContent = [];
for (i = 1; i <= 5; i++) {
  iIdx = (i + 2) % 5
  for (j = 1; j <= 5; j++) {
    jIdx = (j + 3) % 5
    for (k = 1; k <= 5; k++) {
      kIdx = (k + 4) % 5
      bodyContent.push({
        id: ((iIdx * 10) + jIdx) * 10 + kIdx,
        activity: 'activity-' + jIdx,
        status: 'status-' + kIdx
      })
    }
  }
};

var chunkSize = 25;
var content;

var splitContentToStubs = function(content, query) {
  var subStubs = helper.πsplitToChunks(content, chunkSize).map(function(chunkData, index) {
    var localQuery = helper.clone(query || {});
    localQuery.section = index + 1;
    var stub = new MBStub({
      path: '/loans',
      query: localQuery
    });
    stub.setBody({
      "meta": {
        "total": content.length,
        "page": index + 1,
        "page_size": chunkSize,
        "date": new Date()
      },
      loans: chunkData
    });
    return stub;
  });
  stubs = stubs.concat(subStubs);
};

// unsort
content = bodyContent;
splitContentToStubs(content);


// id => asc
['id', 'activity', 'status'].forEach(function(sortName) {
  var content = bodyContent.slice().sort(function(prev, next) {
    var prevStr = prev[sortName].toString();
    var nextStr = next[sortName].toString();
    return prevStr.localeCompare(nextStr);
  });

  splitContentToStubs(content, {
    'sortNames[0]': sortName,
    'sortDirect[0]': 'asc'
  })

});




module.exports = stubs;
