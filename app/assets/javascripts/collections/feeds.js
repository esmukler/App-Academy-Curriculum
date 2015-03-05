NewsReader.Collections.Feeds = Backbone.Collection.extend({
  url: "api/feeds/",
  model: NewsReader.Models.Feed,

  getOrFetch: function(id) {
    var foundModel = this.get(id);
    if (foundModel) {
      foundModel.fetch();
      return foundModel;
    } else {
      var newModel = new NewsReader.Models.Feed({ id: id });
      newModel.fetch();
      this.add(newModel);
      return newModel;
    }
  }
})
