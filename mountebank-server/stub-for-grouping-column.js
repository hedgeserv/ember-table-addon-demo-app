var MBStub = require('./m-b-stub');
var helper = require('./helper');
var allLoans = helper.loadAllLoans();
var stubs = []
var firstLevelCount = 5;

var groups = allLoans.slice(0, firstLevelCount).map(function(group, index) {
  // third loans is not grouped data
  group.isGroupRow = index !== 2;
  group.groupName = 'Group ' + index;
  if (index % 2 === 1) {
    group['children'] = allLoans.slice(index * 100, index * 120);
  }
  return group;
});

var stub = new MBStub({
  path: '/loans',
  query: {
    "group": "true"
  }
});
stub.setBody({
  "meta": {
    "total": firstLevelCount,
    "date": new Date()
  },
  "loans": groups
})

module.exports = stub;
