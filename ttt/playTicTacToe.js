var TicTacToe = require("./index.js")

var game = new TicTacToe.Game();
game.play(function (game) {
  game.end();
});
