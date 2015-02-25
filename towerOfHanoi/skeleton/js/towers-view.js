(function () {
  if (typeof Towers === "undefined") {
    window.Towers = {};
  }

  var View = Towers.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.bindEvents();
    this.setupTowers();
    this.selected = 0;
    this.startTower = null;
  };

  View.prototype.setupTowers = function ( ) {
    var html = "<ul class='grid group'>" +
                "<li class='small'></li><li class='empty'></li><li class='empty'></li>" +
                "<li class='medium'></li><li class='empty'></li><li class='empty'></li>" +
                "<li class='large'></li><li class='empty'></li><li class='empty'></li></ul>"
    this.$el.html(html);
  };

  View.prototype.bindEvents = function () {
    var view = this;
    this.$el.on("click", "li", function(event) {
      console.log(view.selected)

      var $square = $(event.currentTarget);
      var index = $square.index() % 3;

      if (view.selected === 0) {
        view.startTower = index;
        view.selected = 1
        view.getStartPiece().toggleClass("selected");
      } else if (view.selected === 1 &&
                 view.game.isValidMove(view.startTower, index)){

        view.game.move(view.startTower, index);
        view.selected = 0;

        var $startPiece = view.getStartPiece();
        var $endPiece = view.getEndPiece(index);

        $startPiece.toggleClass("selected");
        var size = $startPiece.attr("class");
        $startPiece.toggleClass("empty " + size);
        $endPiece.toggleClass("empty " + size);

      } else {
        view.getStartPiece().toggleClass("selected");
        view.selected = 0;
      }

    });
  };

  View.prototype.getStartPiece = function() {
    for( var i = this.startTower; i < 9; i += 3){
      if( !this.$el.find("li").eq(i).hasClass("empty")){
        return $("li").eq(i);
      }
    }
  };

  View.prototype.getEndPiece = function(index) {
    for( var i = index + 6; i >= 0; i -= 3){
      if( this.$el.find("li").eq(i).hasClass("empty")){
        return this.$el.find("li").eq(i);
      }
    }
  };

})();
