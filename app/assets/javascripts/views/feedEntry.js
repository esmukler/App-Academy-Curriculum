NewsReader.Views.FeedEntry = Backbone.View.extend({
  initialize: function(options) {
    this.model = options.model;

    this.listenTo(this.model, "sync", this.render);
  },

  template: JST['feed_entry'],

  className: 'feed-entry',

  tagName: "li",

  render: function() {
    console.log("entry render")
    this.$el.html(this.template({entry: this.model}));
    return this;
  }
})
