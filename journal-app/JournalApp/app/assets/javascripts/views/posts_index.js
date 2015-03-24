JournalApp.Views.PostsIndex = Backbone.View.extend({

  template: JST['post_index'],

  className: "posts-index",

  tagName: "ul",

  events: {
    "click button.new-post": "goToNew"
  },

  initialize: function(){
    this.listenTo(this.collection, "add change sync remove", this.render);

  },

  render: function(){
    this.$el.empty();
    this.$el.append(this.template);

    this.collection.each( function(post){
      var postTitleItem = new JournalApp.Views.PostsIndexItem({model: post});
      this.$el.append(postTitleItem.render().$el);
    }.bind(this));
    return this;
  },

  goToNew: function(){
    Backbone.history.navigate("#posts/new", {trigger: true});
  }

});
