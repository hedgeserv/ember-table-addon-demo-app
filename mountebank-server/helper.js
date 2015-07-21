exports.splitToChunks = function (body, chunkSize) {
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

exports.clone = function(obj){
	var keys = Object.keys(obj);
	return keys.reduce(function(res, key){
		res[key] = obj[key]
		return res;
	}, {});
};

exports.product = function(firstArr, secondArr, uniq){
	var result = [];
	var item;
	firstArr.forEach(function(firstItem){
		secondArr.forEach(function(secondItem){
			item = firstItem === secondItem && uniq ? [firstItem] : [firstItem, secondItem]
			result.push(item);
		});
	});
	return result;
};
