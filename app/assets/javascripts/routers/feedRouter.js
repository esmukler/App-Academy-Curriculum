NewsReader.Routers.FeedRouter = Backbone.Router.extend({
  initialize: function(options) {
    this.$el = options.$el;
    this.collection = options.collection;
  },

  routes: {
    "": "index",
    "feeds/:id": "feedShow"
  },

  index: function() {
    var indexView = new NewsReader.Views.FeedIndex({collection: this.collection});
    this._swapView(indexView);
  },

  feedShow: function (id) {
    var model = this.collection.getOrFetch(id);
    var showView = new NewsReader.Views.FeedShow({ model: model });
    this._swapView(showView);
  },

  _swapView: function (view) {
    if (this._currentView) {
      this._currentView.remove();
    }
    this._currentView = view;
    this.$el.html(view.render().$el);
  }
})
