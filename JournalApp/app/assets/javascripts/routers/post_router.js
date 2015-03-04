JournalApp.Routers.Posts = Backbone.Router.extend({

  initialize: function(options){
    this.$el = options.$el;
    this._collection = options.collection;

    Backbone.history.start();
  },

  routes: {
    "" : "index",
    "posts" : "index",
    "posts/new" : "new",
    "posts/:id" : "show",
    "posts/:id/edit" : "edit"
  },

  new: function() {
    var post = new JournalApp.Models.Post();
    var postFormView = new JournalApp.Views.PostForm({
      model: post,
      collection: this._collection,
      isNew: true
    });
    this.$el.html(postFormView.render().$el);
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
      model: post,
      isNew: false
    });
    this.$el.html(postFormView.render().$el);
  }


})
