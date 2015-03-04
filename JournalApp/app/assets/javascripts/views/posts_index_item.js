JournalApp.Views.PostsIndexItem = Backbone.View.extend({
  template: JST["post_title"],

  className: "posts-index-item",

  tagName: "li",

  events: {
    "click button.delete": "deletePost",
    "click a.index-link": "goToIndex"
  },


  render: function(){
    this.$el.empty();

    this.$el.append(this.template({ post: this.model}));
    return this;
  },

  goToIndex: function(){
    // event.preventDefault();
    Backbone.history.navigate(
      "",
      {trigger: true}
    );
  },

  deletePost: function(){
    this.model.destroy();
  }

});
