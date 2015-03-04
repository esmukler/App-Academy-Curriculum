window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    alert('Hello from Backbone!');
  },

  JournalApp.Models.Post = Backbone.Model.extend{
    urlRoot: "/posts",
  },

  JournalApp.Collections.Posts = Backbone.Collection.extend{
    url: "/posts",
    model: JournalApp.Models.Post,
    getOrFetch : function(id){
      if (this.get(id)) {
        this.get(id).fetch();

      } else {
        var newModel = new JournalApp.Models.Post({id: id});
        newModel.fetch() {
          success: this.add(newModel)

        }.bind(this);
      }
    }.bind(this)
  }

};

$(document).ready(function(){
  JournalApp.initialize();
});
