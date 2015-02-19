var uniq = function (array) {

  var uniq_arr = [];

  for (var i = 0; i < array.length; i++) {

    var included = false;

    for (var j = 0; j < uniq_arr.length; j++) {

      if (uniq_arr[j] === array[i]) {
        included = true;
        break;
      };
    };

    if (included === false) {
      uniq_arr.push(array[i]);
    };
  };

  return uniq_arr;
};


var twoSum = function (array) {

  var sum_arr = [];

  for (var i = 0; i < array.length; i++) {

    for (var j = i+1; j < array.length; j++) {
      if ((array[i] + array[j]) === 0) {
        sum_arr.push([i,j]);
      };
    };
  };

  return sum_arr;

};


var transpose = function(matrix) {

  var transposed = [];

  for (var i = 0; i < matrix.length; i++) {
    var column = [];

    for (var j = 0; j < matrix[i].length; j++) {
      column.push(matrix[j][i]);
    };

    transposed.push(column);
  };
  return transposed;
};
