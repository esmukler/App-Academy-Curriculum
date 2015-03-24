Array.prototype.uniq = function () {

  var uniq_arr = [];

  for (var i = 0; i < this.length; i++) {

    var included = false;

    for (var j = 0; j < uniq_arr.length; j++) {

      if (uniq_arr[j] === this[i]) {
        included = true;
        break;
      };
    };

    if (included === false) {
      uniq_arr.push(this[i]);
    };
  };

  return uniq_arr;
};


Array.prototype.twoSum = function () {

  var sum_arr = [];

  for (var i = 0; i < this.length; i++) {

    for (var j = i+1; j < this.length; j++) {
      if ((this[i] + this[j]) === 0) {
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
