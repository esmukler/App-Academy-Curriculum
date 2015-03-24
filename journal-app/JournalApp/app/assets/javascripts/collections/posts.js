JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: "api/posts",

  model: JournalApp.Models.Post,

  getOrFetch : function(id){
    if (this.get(id)) {
      return this.get(id);
    } else {
      var newModel = new JournalApp.Models.Post({id: id});
      newModel.fetch({
        success: function(){
          return this.add(newModel)
        }.bind(this)
      });
    }

  }
});
