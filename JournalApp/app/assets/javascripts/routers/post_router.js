JournalApp.Routers.Posts = Backbone.Router.extend({

  initialize: function(options){
    this.$el = options.$el;
    this._collection = options.collection;

    Backbone.history.start();
    this.index();
  },

  routes: {
    "" : "index",
    "posts" : "index",
    "posts/new" : "new",
    "posts/:id" : "show",
    "posts/:id/edit" : "edit"
  },

  new: function() {
    var $content = this.$el.find(".content");
    var post = new JournalApp.Models.Post();
    var postFormView = new JournalApp.Views.PostForm({
      model: post,
      collection: this._collection,
      isNew: true
    });
    $content.html(postFormView.render().$el);
  },


  index: function () {
    var $sidebar = this.$el.find(".sidebar");
    var postsIndexView = new JournalApp.Views.PostsIndex({
      collection: this._collection
    });
    $sidebar.html(postsIndexView.render().$el);
  },

  show: function (id) {
    var $content = this.$el.find(".content");
    var post = this._collection.getOrFetch(id);
    var postShowView = new JournalApp.Views.PostShow({
      model: post
    });
    $content.html(postShowView.render().$el);

  },

  edit: function(id) {
    var $content = this.$el.find(".content");
    var post = this._collection.getOrFetch(id);
    var postFormView = new JournalApp.Views.PostForm({
      model: post,
      isNew: false
    });
    $content.html(postFormView.render().$el);
  }


})
