var myEach = function(array, func) {

  for (var i = 0; i< array.length; i++) {
    func(array[i]);
  };
};

var arr = [];

var addOne = function(num) {
  arr.push(num + 1);
};

var printOne = function(num) {
  console.log(num + 1);
};


var myMap = function(arr, func) {
  var mapped_arr = [];

  var mapHelper = function(el) {
    mapped_arr.push(func(el));
  };

  myEach(arr, mapHelper);

  return mapped_arr;
};

var addTwo = function(num) {
  return num + 2;
};

var myInject = function(arr, init, func) {
  var output = init;

  var injectHelper = function(el) {
    output = func(output, el);
  };

  myEach(arr, injectHelper);
  return output;
};

var adding = function(num1, num2) {
  return num1 + num2;
};

var multiplying = function(num1, num2) {
  return num1 * num2;
};
