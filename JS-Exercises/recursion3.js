
var mergeSort = function(arr) {

  if (arr.length === 1) {
    return arr;
  };

  var midpoint = arr.length / 2;

  var left1 = arr.slice(0, midpoint);
  var right1 = arr.slice(midpoint);

  var mergeHelp = function(left, right) {
    var sorted = [];
    while (left.length > 0 && right.length > 0) {
      if (left[0] < right[0]) {
        var a = left.shift();
        sorted.push(a);
      } else {
        var b = right.shift();
        sorted.push(b);
      };
    };

    return sorted.concat(left).concat(right);

  };

  console.log(arr);
  return mergeHelp(mergeSort(left1), mergeSort(right1));

};
