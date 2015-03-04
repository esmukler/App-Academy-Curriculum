window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    alert('Hello Scott and Eli, from Backbone!');
    var collection = new JournalApp.Collections.Posts();
    var $postsSection = $("section.posts");
    collection.fetch({
      success: function(){
        router = new JournalApp.Routers.Posts({
        $el: $postsSection,
        collection: collection
        })
      }
    });




  }
};


$(document).ready(function(){
  JournalApp.initialize();
});
