JournalApp.Views.PostsIndex = Backbone.View.extend({
  // template: JST["post"],

  className: "posts-index",

  tagName: "ul",

  initialize: function(){
    this.listenTo(this.collection, "sync remove", this.render);
  },

  render: function(){
    this.$el.empty();
    this.collection.each( function(post){
      var postTitleItem = new JournalApp.Views.PostsIndexItem({model: post});
      this.$el.append(postTitleItem.render().$el);
    }.bind(this));
    return this;
  }

});
