"use strict"

var fibs = function(n) {
  var arr = []
  if (n === 0) {
    return arr;
  } else if (n === 1) {
    arr.push(0);
    return arr;
  } else {
    arr = [0, 1];
  };


  var fibs_recur = function(n) {
    if (n === 2) {
      return;
    } else {
      var next = arr[arr.length-2] + arr[arr.length-1];
      arr.push(next);
      fibs_recur(n-1);
    };
  };

  fibs_recur(n);
  return arr;
};


var binarySearch = function(arr, num) {

  var idx = null;
  var found = false;

  var b_recur = function(arr) {
    var midpoint = arr.length/2;
    if (arr.length % 2 !== 0) {
      midpoint += 0.5;
    };

    if (num === arr[midpoint]) {
      idx += midpoint;
      found = true;
      return;
    } else if (num < arr[midpoint]) {
      var left_arr = arr.slice(0, midpoint);
      b_recur(left_arr);
    } else if (num > arr[midpoint]) {
      var right_arr = arr.slice(midpoint, arr.length);
      idx += midpoint;
      b_recur(right_arr);
    } else {
      return;
    };
  };

  b_recur(arr);

  if (found){
    return idx;
  } else {
    return null;
  };

};


var makeChangeUSA = function(num, coins) {
  var arr = coins.slice();
  var bestChange = [];

  var changeArray = [];

  var mcRecur = function() {
    if (num === 0 || arr.length === 0) {
      return;
    } else if (num >= arr[0]) {
      changeArray.push(arr[0]);
      num -= arr[0];
      mcRecur();
    } else {
      arr.shift();
      mcRecur();
    };
  };

  mcRecur();
  return changeArray;
};

var makeChange = function(num, coins) {
  var arr = coins.slice();
  var bestChange = [];
  for (var j = 0; j < num; j++) {
    bestChange.push(1);
  };
  var originalNum = num;
  var changeArray = [];
  var storedArray = [];

  var mcRecur = function() {

    for (var i = 0; i< arr.length; i++) {
      if (num === 0) {
        if (changeArray.length < bestChange.length) {
          bestChange = changeArray.slice();
          changeArray = [];
          num = originalNum;
          return;
        };
      }
      else if (num >= arr[i]) {
        changeArray.push(arr[i]);
        num -= arr[i];
        mcRecur();
      };
    };
  };

  mcRecur();
  return bestChange;
};
