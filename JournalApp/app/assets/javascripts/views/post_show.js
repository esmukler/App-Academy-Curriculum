JournalApp.Views.PostShow = Backbone.View.extend({
  template: JST["post_show"],

  className: "post-show",

  tagName: "article",

  events: {
  },

  id: function () {
    this.model.id
  },

  render: function(){
    this.$el.empty();

    this.$el.append(this.template({ post: this.model }));
    return this;
  },

});
