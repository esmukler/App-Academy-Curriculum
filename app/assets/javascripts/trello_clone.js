window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var $mainDiv = $('#main');

    var boards = new TrelloClone.Collections.Boards;
    boards.fetch();

    var boardsRouter = new TrelloClone.Routers.Router({
      collection: boards,
      $rootEl: $mainDiv
    });

    Backbone.history.start();
  }
};

$(document).ready(function(){
  TrelloClone.initialize();
});
