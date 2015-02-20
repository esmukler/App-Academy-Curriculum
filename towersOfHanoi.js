var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame () {
  this.stacks = [[1,2,3], [], []];
};

HanoiGame.prototype.isWon = function () {
  var firstStackEmpty = (this.stacks[0].length === 0);
  var secondOrThirdOccupied = (this.stacks[1].length === 3 ||
    this.stacks[2].length === 3)

  if ( firstStackEmpty && secondOrThirdOccupied ) {
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {
  var startTower = this.stacks[startTowerIdx];
  var endTower   = this.stacks[endTowerIdx];

  if (startTower.length === 0) {
    return false;
  }
  else if (startTower[0] > endTower[0]) {
    return false;
  }
  else {
    return true
  }
};

HanoiGame.prototype.move = function (startTowerIdx, endTowerIdx) {
  if (this.isValidMove(startTowerIdx, endTowerIdx)) {
    var startTower = this.stacks[startTowerIdx];
    var endTower = this.stacks[endTowerIdx];

    endTower.unshift(startTower.shift());
    return true
  }
  else {
    return false
  }
};

HanoiGame.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function (callback) {
  this.print();

  reader.question("Which stack will you take from? (0, 1, or 2) ",
    function (startIdxString) {
      reader.question("Which stack will you move to? ",
        function (endIdxString) {
          var startTowerIdx = parseInt(startIdxString);
          var endTowerIdx   = parseInt(endIdxString);

          callback(startTowerIdx, endTowerIdx);

        })
    });
};

HanoiGame.prototype.run = function (completionCallback) {
  var game = this;

  this.promptMove( function (startTowerIdx, endTowerIdx) {

    if (game.move(startTowerIdx, endTowerIdx)) {

      if (game.isWon()) {
        completionCallback(game);
      }
      else {
        game.run(completionCallback);
      }
    }
    else {
      throw "Not a valid move."
    }
  });
};

var hanoi = new HanoiGame();
hanoi.run(function (game) {
  game.print();
  console.log("Congratulations! You won.");
  reader.close();
});
