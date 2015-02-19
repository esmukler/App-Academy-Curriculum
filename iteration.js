var bubbleSort = function(arr) {

  var sorting = true;

  while (sorting) {
    sorting = false;
    for (var i = 0; i < arr.length - 1; i++) {
      if (arr[i] > arr[i+1]) {
          var a = arr[i];
          var b = arr[i+1];

          arr[i+1] = a;
          arr[i] = b;
          sorting = true;
      };
    };
  };

  return arr;
};


var subString = function(string) {

  var sub_arr = [];

  for (i=0; i < string.length; i ++) {
    for (j = 1; (j + i) <= string.length; j++) {
      sub_arr.push(string.substr(i, j));
    };
  };

return sub_arr;
};
