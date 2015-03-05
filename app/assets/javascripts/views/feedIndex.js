NewsReader.Views.FeedIndex = Backbone.View.extend({
  initialize: function(options) {
    this.collection = options.collection;

    this.listenTo(this.collection, "sync", this.render)
  },

  template: JST['feed_index'],

  tagName: 'div',

  className: 'feed-index',

  render: function() {
    console.log("index render");
    this.$el.html(this.template({feeds: this.collection}));
    return this;
  }

})
