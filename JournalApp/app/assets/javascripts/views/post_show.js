JournalApp.Views.PostShow = Backbone.View.extend({
  template: JST["post_show"],

  className: "post-show",

  tagName: "article",

  events: {
    "click button.delete": "deletePost"
  },

  id: function () {
    this.model.id
  },

  deletePost: function(){
    this.model.destroy();
    this.remove();
    Backbone.history.navigate("#", {trigger: true});
  },

  render: function(){
    this.$el.empty();

    this.$el.append(this.template({ post: this.model }));
    return this;
  },

});
