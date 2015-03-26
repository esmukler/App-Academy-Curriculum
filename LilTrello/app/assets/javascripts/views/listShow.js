TrelloClone.Views.ListShow = Backbone.View.extend({

  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.cards(), "add remove sync", this.render);
  },

  template: JST["list_show"],

  className: "list",

  tagName: "li",

  events: {
    "click button.new-card" : "newCard",
    "click button.delete-list": "deleteList",
    "sortupdate .cards": "updateOrder"
  },

  render: function() {
    var cards = this.model.cards();
    var renderedContent = this.template({
      list: this.model, cards: cards
    })
    this.$el.html(renderedContent);
    this.$el.attr("data-id", this.model.id);

    var $cards = this.$el.find(".cards");
    $cards.sortable();

    cards.sort();

    cards.each(function(card) {
      var cardShow = new TrelloClone.Views.CardShow({ model: card });
      $cards.append(cardShow.render().$el)
    })
    return this;
  },

  updateOrder: function(event, ui) {
    var newOrder = [];
    var $children = $($(event.currentTarget).children())
    for (var i = 0; i< $children.length; i++) {
      newOrder.push($($children[i]).attr("data-id"));
    };
    console.log(newOrder)
    var cards = this.model.cards();

    if (newOrder) {
      for (var j = 0; j < newOrder.length; j++) {
        cards.each(function(card) {
          if (newOrder[j] == card.id) {
            card.save({ord: j})
          }
        })
      }
    }
    this.render();
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
