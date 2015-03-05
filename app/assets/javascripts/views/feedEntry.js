NewsReader.Views.FeedEntry = Backbone.View.extend({
  initialize: function(options) {
    this.model = options.model;
    console.log("entry init");

    this.listenTo(this.model, "sync", this.render);
  },

  template: JST['feed_entry'],

  className: 'feed-entry',

  tagName: "li",

  render: function() {
    this.$el.html(this.template({entry: this.model}));
    return this;
  }
})
