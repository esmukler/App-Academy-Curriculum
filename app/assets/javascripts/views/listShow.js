TrelloClone.Views.ListShow = Backbone.View.extend({

  initialize: function() {
    this.listenTo(this.model, "sync", this.render)
    this.listenTo(this.model.cards(), "add remove sync", this.render)
  },

  template: JST["list_show"],


  className: "list",

  tagName: "li",

  events: {
    "click button.new-card" : "newCard",
    "click button.delete-list": "deleteList"
  },

  render: function() {
    var renderedContent = this.template({
      list: this.model, cards: this.model.cards()
    })
    this.$el.html(renderedContent);
    var $cards = this.$el.find(".cards");

    this.model.cards().each(function(card) {
      var cardShow = new TrelloClone.Views.CardShow({ model: card });
      $cards.append(cardShow.render().$el)
    })
    return this;
  },

  newCard: function(event) {
    var newCard = new TrelloClone.Models.Card()

    var cardForm = new TrelloClone.Views.CardForm({
      collection: this.model.cards(),
      model: newCard
    });

    $(event.currentTarget).after(cardForm.render().$el);
  },

  deleteList: function(event) {
    this.model.destroy();
  }



})
