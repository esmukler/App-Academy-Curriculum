var Board = require('./board.js');
var readline = require('readline');

function Game (reader) {
  this.board = new Board();
  this.mark = 'x';
  this.reader = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });
};

Game.prototype.promptMove = function (callback) {
  this.board.print();
  this.reader.question("What square do you want to move to? ", function (square) {

    callback(square);
  });
};

Game.prototype.switchMark = function () {
  this.mark = (this.mark === 'x' ? 'o' : 'x');
};

Game.prototype.play = function (completionCallback) {
  var game = this;

  console.log(this.mark + "'s turn.");

  this.promptMove( function(square) {
    if (game.boardEmptyAt(square)) {
      game.board.placeMark(square, game.mark);

      if (game.board.won()) {
        completionCallback(game, true);
      }
      else if (game.board.draw()) {
        completionCallback(game, false);
      }
      else {
        game.switchMark();
        game.play(completionCallback);
      }

    } else {
      throw "Not a valid move";
    }
  });
};

Game.prototype.boardEmptyAt = function (square) {
  return this.board.empty(square);
};

Game.prototype.end = function (won) {
  this.board.print();
  if (won) {
    console.log("Congratulations " + this.mark + ", you won!");
  } else {
    console.log("Cat's game!")
  }
  this.reader.close();
};

module.exports = Game;
