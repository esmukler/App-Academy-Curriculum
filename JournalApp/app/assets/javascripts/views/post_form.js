JournalApp.Views.PostForm = Backbone.View.extend({
  template: JST["post_form"],

  className: "post-form",

  tagName: "form",

  events: {
    "click button.submit-form" : "updatePost"
  },

  render: function(){
    this.$el.empty();

    this.$el.append(this.template({ post: this.model }));
    return this;
  },

  updatePost: function(event) {
    event.preventDefault();
    var formData = this.$el.serializeJSON();
    var isNew = ( typeof this.model.id === "undefined" ) ? true : false;
    this.model.save(formData.post, {
      success: function(){
        if (isNew){
          this.collection.add(this.model, {merge: true});
        }
        Backbone.history.navigate( "", {trigger: true});
      }.bind(this),
      error: function(){
        Backbone.history.navigate(
          "#posts/" + this.model.id + "/edit", {trigger: true});
      }.bind(this)
    });
  }

});
