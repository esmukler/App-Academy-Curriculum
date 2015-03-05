NewsReader.Routers.FeedRouter = Backbone.Router.extend({
  initialize: function(options) {
    this.$el = options.$el;
    this.collection = options.collection;
  },

  routes: {
    "": "index"
  },

  index: function() {
    this.collection.fetch({
      success: function () {
        var indexView = new NewsReader.Views.FeedIndex({collection: this.collection});
        this.$el.append(indexView.render().$el);
      }.bind(this)
    })
  }
})
