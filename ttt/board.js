function Board () {
  this.board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]];
  this.map = {
    '1': [0, 0],
    '2': [0, 1],
    '3': [0, 2],
    '4': [1, 0],
    '5': [1, 1],
    '6': [1, 2],
    '7': [2, 0],
    '8': [2, 1],
    '9': [2, 2]
  };
};

Board.prototype.print = function() {
  for (var i = 0; i < 3; i++) {
    console.log(this.board[i]);
  };
};

Board.prototype.won = function() {
  var b = this.board;

  if ((b[0][0] === b[0][1]) && (b[0][1] === b[0][2]) ||
    (b[1][0] === b[1][1]) && (b[1][1] === b[1][2]) ||
    (b[2][0] === b[2][1]) && (b[2][1] === b[2][2]) ||
    (b[0][0] === b[1][0]) && (b[1][0] === b[2][0]) ||
    (b[0][1] === b[1][1]) && (b[1][1] === b[2][1]) ||
    (b[0][2] === b[1][2]) && (b[1][2] === b[2][2]) ||
    (b[0][0] === b[1][1]) && (b[1][1] === b[2][2]) ||
    (b[2][0] === b[1][1]) && (b[1][1] === b[0][2])) {
    return true;
  } else {
    return false;
  }
};

Board.prototype.draw = function () {
  var _draw = true

  for (var i = 1; i <= 9; i++) {
    if (this.empty(i.toString())) {
      _draw = false;
    }
  }

  return _draw;
};

Board.prototype.placeMark = function (square, mark) {
  var row = this.map[square][0];
  var col = this.map[square][1];
  this.board[row][col] = mark;
};

Board.prototype.empty = function (square) {
  var row = this.map[square][0];
  var col = this.map[square][1];
  var valueAtSquare = this.board[row][col];

  if (typeof(valueAtSquare) === 'number') {
    return true;
  } else {
    return false;
  }
};

module.exports = Board;
