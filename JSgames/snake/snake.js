(function() {
  if (window.Snake === undefined) {
    window.SnakeGame = {};
  }

 var Snake = SnakeGame.Snake = function () {
   this.segments = [Coord.generateRandom()];
   this.dir = "E";
 }

 Snake.prototype.move = function () {
   var newSeg = new Coord(this.segments[0].plus(this.dir));
   var pos = this.segments.pop();
   this.segments.unshift(newSeg);
 };

 Snake.prototype.turn = function (dir) {
   this.dir = dir;
 };

 Snake.DIR = ["N","E","S","W"];

 var Coord = SnakeGame.Coord = function (pos) {
   this.x = pos[0];
   this.y = pos[1];
 }

 Coord.prototype.plus = function (dir) {
   var addCoord = [];
   switch (dir) {
     case 'N':
       addCoord = [-1, 0];
       break;
     case 'E':
       addCoord = [0, 1];
       break;
     case 'S':
       addCoord = [1, 0];
       break;
     case 'W':
       addCoord = [0, -1];
       break;
   }
   return [this.x + addCoord[0], this.y + addCoord[1]];
 }

 var generateRandom = Coord.generateRandom = function (){
   var x = Math.floor(Math.random() * Board.DIM_X);
   var y = Math.floor(Math.random() * Board.DIM_Y);
   return new Coord([x,y]);
 }

 var Board = SnakeGame.Board = function () {
   this.snake = new Snake();
   this.grid = this.setUpBoard();
   this.apples = [];
 }

 Board.DIM_X = 20;
 Board.DIM_Y = 30;

Board.prototype.setUpBoard = function () {
  var grid = [];
  for (var i = 0; i < Board.DIM_X; i++) {
    grid.push([]);
    for (var j = 0; j < Board.DIM_Y; j++) {
      grid[i].push(".");
    }
  }
  return grid;
};

Board.prototype.render = function () {
  var grid = this.grid;
  var gridString = ""
  for (var i = 0; i < Board.DIM_X; i++) {
    for (var j = 0; j < Board.DIM_Y; j++) {
      grid[i][j] = ".";
    }
  }
  this.snake.segments.forEach(function (el){
    grid[el.x][el.y] = "s";
  })
  for (var i = 0; i < Board.DIM_X; i++) {
    for (var j = 0; j < Board.DIM_Y; j++) {
      gridString += grid[i][j];
    }
    gridString += "\n";
  }


  console.log(gridString);
}

})();
