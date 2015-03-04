window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    alert('Hello Scott and Eli, from Backbone!');
    var collection = new JournalApp.Collections.Posts();
    var postsIndexView = new JournalApp.Views.PostsIndex({collection: collection});
    var $section = $("section.posts");
    $section.append(postsIndexView.render().$el);
  }
};


$(document).ready(function(){
  JournalApp.initialize();
});
