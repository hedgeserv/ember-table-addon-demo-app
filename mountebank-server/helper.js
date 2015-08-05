var fs = require('fs');

var splitToChunks = function (body, chunkSize) {
  var chunkNumber = body.length / chunkSize;
  var chunks = [];
  var startIndex = 0;
  var currentChunk;
  for (var i = 0; i < chunkNumber; i++) {
    currentChunk = body.slice(0 + startIndex, chunkSize + startIndex);
    chunks.push(currentChunk);
    startIndex += chunkSize;
  }
  return chunks;
};
exports.splitToChunks = splitToChunks;

exports.clone = function (obj) {
  var keys = Object.keys(obj);
  return keys.reduce(function (res, key) {
    res[key] = obj[key];
    return res;
  }, {});
};

var isNumber = function (value) {
  return !!(value + '').match(/^(-|\d+|\.)$/);
};

var compare = function (prev, next, key) {
  if (!!key) {
    prev = prev[key];
    next = next[key];
  }
  if (isNumber(prev) && isNumber(next)) {
    return prev - next;
  }
  return prev.localeCompare(next);
};

exports.compare = compare;

var loadJsonFile = function (fileName) {
  return JSON.parse(fs.readFileSync(__dirname + '/../datasets/' + fileName));
};

exports.loadJsonFile = loadJsonFile;

exports.loadAllLoans = function () {
  var allLoans = [1, 2, 3, 4, 5, 6, 7].map(function (index) {
    return loadJsonFile(index + '.json');
  }).reduce(function (previous, current) {
    var loans = current.loans.map(function (loan) {
      return {
        id: loan.id,
        activity: loan.activity,
        status: loan.status,
        use: loan.use,
        sector: loan.sector
      };
    });
    return previous.concat(loans);
  }, []);
  return allLoans;
};

var concat = function (firstArr, secondArr) {
  secondArr.forEach(function (item) {
    firstArr.push(item);
  });
};
exports.concat = concat;


function arrayEqual(first, second) {
  return JSON.stringify(first) == JSON.stringify(second);
}

var uniq = function (arr) {
  var result = [];
  arr.forEach(function (item) {
    var has = result.some(function (i) {
      return arrayEqual(i, item);
    });
    if (!has) {
      result.push(item);
    }
  });
  return result;
};

module.exports.uniq = uniq;
