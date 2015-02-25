(function () {
  if (typeof SnakeGame === "undefined") {
    window.SnakeGame = {};
  }

  var View = SnakeGame.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.bindEvents();
    this.setupBoard();
    this.start();
  };

  View.prototype.start = function() {
    var view = this;
    setInterval( function() {
      console.log(view);
      view.game.snake.move();
      console.log(view.game.render());
    }, 500);

  };


  View.prototype.setupBoard = function ( ) {

    var html = "<ul class='grid group'>"
    for (var i = 0; i < SnakeGame.Board.DIM_X; i++) {
      for (var j = 0; j < SnakeGame.Board.DIM_Y; j++) {
        html += "<li></li>"
      }
    }

    html += "</ul><p class='message'></p>";

    this.$el.html(html);
  };

  View.prototype.bindEvents = function () {
    var view = this;
    $(document).on("keydown", function(event){
      event.preventDefault();
      console.log(event.which);
      view.snakeTurn(event.which);
    })
  };

  View.prototype.snakeTurn = function(code) {
    if(code === 37){
      this.game.snake.turn("W");
    } else if (code === 38) {
      this.game.snake.turn("N");
    } else if (code === 39) {
      this.game.snake.turn("E");
    } else if (code === 40) {
      this.game.snake.turn("S");
    }
  };

})();
