TrelloClone.Collections.Boards = Backbone.Collection.extend({
  url: "api/boards",

  model: TrelloClone.Models.Board,

  getOrFetch: function(id) {
    if (this.get(id)) {
      var model = this.get(id);
      model.fetch();
      return model;
    } else {
      var newModel = new TrelloClone.Models.Board({ id: id});
      newModel.fetch();
      this.add(newModel);
      return newModel;
    }
  }

})
