TrelloClone.Models.List = Backbone.Model.extend({
  urlRoot: "api/lists",

  parse: function(jsonResp) {

    if (jsonResp.cards) {
      this.cards().set(jsonResp.cards, {parse: true});
      delete jsonResp.cards;
    }
    return jsonResp;
  },

  cards: function() {
    if (!this._cards) {
      this._cards = new TrelloClone.Collections.Cards([], {
      list: this
      })
    }
    return this._cards;
  }

})
