TrelloClone.Views.BoardForm = Backbone.View.extend({
  initialize: function() {

  },

  template: JST["board_form"],

  tagName: "form",

  className: "board-form",

  events: {
    "submit": "createNewBoard"
  },

  createNewBoard: function(event) {
    event.preventDefault();
    var formData = $(event.target).serializeJSON();
    var newBoard = this.collection.create( formData.board, {
      success: function() {
        var showRoute = "#boards/" + newBoard.id;
        Backbone.history.navigate(showRoute, {trigger : true})
      }
    });
  },

  render: function() {
    this.$el.html(this.template());
    return this;
  },


})
