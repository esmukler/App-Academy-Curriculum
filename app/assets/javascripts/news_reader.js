window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var $content = $('#content');
    var collection = new NewsReader.Collections.Feeds;
    collection.fetch();
    var router = new NewsReader.Routers.FeedRouter({
      $el: $content,
      collection: collection
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
