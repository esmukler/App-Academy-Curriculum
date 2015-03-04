JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: "api/posts",
  model: JournalApp.Models.Post,
  getOrFetch : function(id){
    if (this.get(id)) {
      this.get(id).fetch();

    } else {
      var newModel = new JournalApp.Models.Post({id: id});
      newModel.fetch({
        success: function(){
          this.add(newModel)
        }.bind(this)
      });
    }
  }
});
