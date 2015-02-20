var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var addNumbers = function(sum, numsLeft, completionCallback) {

  if (numsLeft > 0) {
    reader.question("Enter a number: ", function(numStr) {
      var numInt = parseInt(numStr);
      var increasedSum = sum + numInt;
      var decreasedNumsLeft = numsLeft - 1;

      console.log(increasedSum);

      addNumbers(increasedSum, decreasedNumsLeft, completionCallback);
    });
  } else {
    completionCallback(sum);
  }
};

addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
  reader.close();
});
