JournalApp.Routers.Posts = Backbone.Router.extend({

  initialize: function(options){
    this.$el = options.$el;
    this._collection = options.collection;

    Backbone.history.start();
  },

  routes: {
    "" : "index",
    "posts" : "index",
    "posts/:id" : "show",
    "posts/:id/edit" : "edit"
  },


  index: function () {
    var postsIndexView = new JournalApp.Views.PostsIndex({
      collection: this._collection
    });
    this.$el.html(postsIndexView.render().$el);
  },

  show: function (id) {

    var post = this._collection.getOrFetch(id);
    var postShowView = new JournalApp.Views.PostShow({
      model: post
    });
    this.$el.html(postShowView.render().$el);

  },

  edit: function(id) {
    var post = this._collection.getOrFetch(id);
    var postFormView = new JournalApp.Views.PostForm({
      model: post
    });
    this.$el.html(postFormView.render().$el);
  }


})
