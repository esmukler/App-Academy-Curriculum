TrelloClone.Collections.Lists = Backbone.Collection.extend({
  url: "api/lists",

  model: TrelloClone.Models.List,

  initialize: function(models, options) {
    this.board = options.board
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
      var newModel = new TrelloClone.Models.List({ id: id });
      newModel.fetch();
      this.add(newModel);
      return newModel;
    }
  }

})
