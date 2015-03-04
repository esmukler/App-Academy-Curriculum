JournalApp.Views.PostsIndexItem = Backbone.View.extend({
  template: JST["post_title"],

  className: "posts-index-item",

  tagName: "li",

  events: {
    "click button.delete": "deletePost"
  },


  render: function(){
    this.$el.empty();

    this.$el.append(this.template({ title: this.model.escape("title")}));
    return this;
  },

  deletePost: function(){
    this.model.destroy();
  }

});
