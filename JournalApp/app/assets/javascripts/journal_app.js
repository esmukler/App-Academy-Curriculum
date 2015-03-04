window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {

    var collection = new JournalApp.Collections.Posts();
    var $posts = $("section.posts");
    collection.fetch({
      success: function(){
        router = new JournalApp.Routers.Posts({
        $el: $posts,
        collection: collection
        })
        
      }
    });




  }
};


$(document).ready(function(){
  JournalApp.initialize();
});
