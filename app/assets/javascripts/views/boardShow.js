TrelloClone.Views.BoardShow = Backbone.View.extend({
  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.lists(), "add remove sync", this.render);
  },

  template: JST["board_show"],


  className: "board-container",

  events: {
    "click button.new-list": "newList",
    "click button.index" : "goToIndex",
    "click button.delete-board": "deleteBoard",
  },

  render: function() {
    this.$el.html(this.template({ board: this.model }));
    var $lists = $(".lists");
    this.model.lists().each(function(list) {
      var listShow = new TrelloClone.Views.ListShow({ model: list });
      $lists.append(listShow.render().$el)
    })

    return this;
  },


  newList: function(event) {
    var newList = new TrelloClone.Models.List()

    var listForm = new TrelloClone.Views.ListForm({
      collection: this.model.lists(),
      model: newList
    })
    var $button = $(event.currentTarget);
    $button.after(listForm.render().$el);
  },

  goToIndex: function() {
    Backbone.history.navigate("boards", {trigger: true});
  },

  deleteBoard: function() {
    this.model.destroy({
      success: this.goToIndex
    });
  }


})
