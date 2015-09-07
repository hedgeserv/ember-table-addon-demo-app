var MBStub = require('./m-b-stub');
var helper = require('./helper');
var url = '/chunkedGroups';
var pageSize = 10;

module.exports = function(records) {
  var resourceNames = ['accountSections', 'accountTypes', 'accountCodes'];
  for (var i = 0; i < 20; i++) {
    records[0].children[2].children.push(helper.clone(records[0].children[2].children[0]));
  }

  generateRecordId(records, 0);

// unsort grouped stubs

  var stubs = doMakeNestedStubs({
    children: records
  }, resourceNames, {});
  return stubs;
};


function generateRecordId(records, parentId) {
  for (var i = 0; i < records.length; i++) {
    var record = records[i];
    record.id = (i + 1) + parentId * 100;
    if (record.children) {
      generateRecordId(record.children, record.id);
    }
  }
}

function removeChildren(obj) {
  var doRemoveChildren = function (object) {
    var cloneObject = helper.clone(object);
    cloneObject.children = [];
    return cloneObject;
  };
  if (Array.isArray(obj)) {
    return obj.map(function (x) {
      return doRemoveChildren(x);
    });
  }
  return doRemoveChildren(obj);
}

function doMakeNestedStubs(theRecord, resourceNames, parentQuery, localUrl) {
  localUrl = localUrl || url;
  var localStubs = [];
  if (theRecord.children) {
    var chunkedGroups = removeChildren(theRecord.children);
    localStubs.push(createStub(localUrl, chunkedGroups));
    theRecord.children.forEach(function (value) {
      var theQuery = helper.clone(parentQuery);
      var tempUrl = localUrl;
      if (tempUrl !== url) {
        tempUrl += '/' + value.id;
      }
      tempUrl += '/' + resourceNames[0];
      localStubs = localStubs.concat(doMakeNestedStubs(value, resourceNames.slice(1), theQuery, tempUrl));
    });
  }
  return localStubs;
}

function createStub (path, data){
  var stub = new MBStub({
    "path": path
  });
  stub.setBody({
    "meta": {
      "total": data.length,
      "pageSize": pageSize,
      "date": new Date()
    },
    'chunkedGroups': data
  });
  return stub;
}
