window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {

    var collection = new JournalApp.Collections.Posts();
    var $postsIndexSidebar = $("section.sidebar");
    collection.fetch({
      success: function(){
        router = new JournalApp.Routers.Posts({
        $el: $postsIndexSidebar,
        collection: collection
        })
      }
    });




  }
};


$(document).ready(function(){
  JournalApp.initialize();
});
