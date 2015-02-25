(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.bindEvents();
    this.setupBoard();
  };

  View.prototype.bindEvents = function () {
    var view = this;
    this.$el.on("click", "li", function(event) {

      var $square = $(event.currentTarget);
      if ($square.text() === "") {
        view.makeMove($square);
      }
    })
  };

  View.prototype.makeMove = function ($square) {
    var index = $square.index();
    var pos = [Math.floor(index/3), index%3 ]
    var game = this.game;

    if (game.currentPlayer === 'x'){
      $square.addClass("selectedX");
      $square.text("X");
    } else {
      $square.addClass("selectedO");
      $square.text("O");
    }

    game.playMove(pos);

    if (game.isOver()) {
      this.$el.append($("<p>"));

      if (game.winner()) {
        this.$el.find("p").text(game.winner() + " has won!");

      } else {
        this.$el.find("p").text("NO ONE WINS!");
      }
      this.$el.off();
    }
  };

  View.prototype.setupBoard = function ( ) {
    var html = "<ul class='grid group'><li></li><li></li><li></li>" +
                    "<li></li><li></li><li></li>" +
                    "<li></li><li></li><li></li></ul>"
    this.$el.html(html);

  };
})();
