var Board = require('./board.js');

var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function Game (reader) {
  this.board = new Board();
  this.mark = 'x';
};

Game.prototype.promptMove = function (callback) {
  this.board.print();
  reader.question("What square do you want to move to? ", function (square) {

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
    if (game.board.empty(square)) {
      game.board.placeMark(square, game.mark);

      if (game.board.won()) {
        completionCallback(game);
      } else {
        game.switchMark();
        game.play(completionCallback);
      }

    } else {
      throw "Not a valid move";
    }
  });
};

Game.prototype.end = function () {
  this.board.print();
  console.log("Congratulations " + this.mark + ", you won!");
  this.reader.close();
};

module.exports = Game;
