"use strict"

var range = function(start, end) {
  var arr = [];
  if (end < start) {
    return [];
  } else if (end === start) {
    return [start];
  };
  var recursive_range = function(next, end) {
    if (next != end) {
      arr.push(next);
      next ++;
      recursive_range(next, end);
    } else {
      return;
    }
  };
  recursive_range(start, end);
  return arr;
};


var sum = function(arr) {
  var total = arr.shift();

  var recur = function(arr) {
    if (arr.length === 0) {
      return;
    } else {
      total += arr.shift();
      recur(arr);
    };
  };

  recur(arr);
  return total;
};


var exp1 = function(base, exp) {
  var answer = 1;

  var recurExp1 = function (base, exp) {
    if (exp > 0) {
      answer *= base;
      exp--;
      recurExp1(base, exp);
    } else {
      return;
    };
  };

  recurExp1(base, exp);
  return answer;

};



var exp2 = function(base, exp) {
  var answer = 1;

  var recurExp2 = function (base, exp) {
    if (exp === 0) {
      return;
    } else if (exp === 1) {
      answer *= base;
      return;
    } else if (exp % 2 === 0) {
      recurExp2(base, exp/2);
      recurExp2(base, exp/2);
    } else if (exp % 2 !== 0) {
      answer *= base;
      recurExp2(base, (exp - 1));
    };
  };

  recurExp2(base, exp);
  return answer;
};
