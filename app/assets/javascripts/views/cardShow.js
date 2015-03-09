TrelloClone.Views.CardShow = Backbone.View.extend({

  initialize: function() {
    this.listenTo(this.model, "sync", this.render)
  },

  template: JST["card_show"],

  tagName: "li",
  className: "card",

  events: {
    "click button.delete-card": "deleteCard",
  },

  render: function() {
    var renderedContent = this.template({ card: this.model });
    this.$el.html(renderedContent);
    this.$el.attr("data-id", this.model.id);

    return this;
  },


  deleteCard: function(event) {
    this.model.destroy();
  }



})
