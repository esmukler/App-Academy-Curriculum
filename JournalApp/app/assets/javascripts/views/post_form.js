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
    console.log(formData.post);
    this.model.save(formData.post, {
      success: function(){
        Backbone.history.navigate( "", {trigger: true});
      },
      error: function(){
        Backbone.history.navigate(
          "#posts/" + this.model.id + "/edit", {trigger: true});
      }.bind(this)
    });
  }

});
