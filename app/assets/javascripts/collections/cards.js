TrelloClone.Collections.Cards = Backbone.Collection.extend({
  url: "api/cards",

  model: TrelloClone.Models.Card,

  initialize: function(models, options) {
    this.list = options.list
  },

  comparator: function(model) {
    return model.get("ord")
  },

  getOrFetch: function(id) {
    if (this.get(id)) {
      var model = this.get(id);
      model.fetch();
      return model;
    } else {
      var newModel = new TrelloClone.Models.Card({ id: id });
      newModel.fetch();
      this.add(newModel);
      return newModel;
    }
  }

})
