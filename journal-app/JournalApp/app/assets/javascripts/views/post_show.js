JournalApp.Views.PostShow = Backbone.View.extend({
  template: JST["post_show"],

  className: "post-show",

  tagName: "article",

  events: {
    "click button.delete": "deletePost",
    "dblclick p.post-title" : "editPostTitle",
    "dblclick p.post-body" : "editPostBody",
    "dblclick input.edit-title" : "editPostTitle",
    "dblclick textarea.edit-body" : "editPostBody",
  },

  initialize: function(){
    this.listenTo(this.model, "change", this.render);
  },

  id: function () {
    this.model.id
  },

  deletePost: function(){
    this.model.destroy();
    this.remove();
    Backbone.history.navigate("#", {trigger: true});
  },

  render: function(){
    this.$el.empty();

    this.$el.append(this.template({ post: this.model }));
    return this;
  },

  editPostTitle: function(event) {
    event.preventDefault();
    this.$el.find(".post-title").toggleClass("hidden");
    this.$el.find(".edit-title").toggleClass("hidden");
    this.updatePost(this.$el.find(".edit-title"));
  },

  editPostBody: function(event) {
    event.preventDefault();
    this.$el.find(".post-body").toggleClass("hidden");
    this.$el.find(".edit-body").toggleClass("hidden");

    this.updatePost(this.$el.find(".edit-body"));
  },

  updatePost: function(el) {
    var formData = el.serializeJSON();
    console.log(formData);
    this.model.save(formData.post, {
      patch: true,
      success: function() {
        console.log("success");
      }
    });
  }

  // keyAction: function(event){
  //   console.log(event.keyCode);
  //   if (event.keyCode === 13){
  //     this.$el.find(".post-title").removeClass("hidden");
  //     this.$el.find(".edit-title").removeClass("hidden");
  //     this.$el.find(".edit-title").addClass("hidden");
  //   }
  // }

});
