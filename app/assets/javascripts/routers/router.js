TrelloClone.Routers.Router = Backbone.Router.extend({
  initialize: function(options) {
    this.$rootEl = options.$rootEl;

    this.collection = options.collection;
  },

  routes: {
    "": "index",
    "boards": "index",
    "boards/:id" : "show"
  },

  index: function() {
    this.collection.fetch();
    var indexView = new TrelloClone.Views.BoardIndex({
      collection: this.collection
    })

    this._swapView(indexView);
  },

  show: function(id) {
    var model = this.collection.getOrFetch(id);
    var showView = new TrelloClone.Views.BoardShow({
      model: model
    });

    this._swapView(showView);
  },


  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(this._currentView.render().$el);
  },

})
