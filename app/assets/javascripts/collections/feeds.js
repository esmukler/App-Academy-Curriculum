NewsReader.Collections.Feeds = Backbone.Collection.extend({
  url: "api/feeds/",
  model: NewsReader.Models.Feed,

  getOrFetch: function(id) {
    if (id) {
      return this.get(id);
    } else {
      var newModel = new NewsReader.Model.Feed
      newModel.fetch({
        success: function() {
          this.add(newModel);
        }.bind(this)
      })
      return newModel;
    }
  }
})
