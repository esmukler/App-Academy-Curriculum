NewsReader.Views.FeedIndex = Backbone.View.extend({
  initialize: function(options) {
    this.collection = options.collection;

    this.listenTo(this.collection, "sync destroy", this.render)
  },

  events: {
    "click button.destroy-feed": "deleteFeed"
  },

  template: JST['feed_index'],

  tagName: 'div',

  className: 'feed-index',

  render: function() {
    console.log("index render");
    this.$el.html(this.template({feeds: this.collection}));
    return this;
  },

  deleteFeed: function (event) {
    event.preventDefault();
    var id = $(event.currentTarget).data("id");
    var feed = this.collection.get(id);
    feed.destroy();
  }

})
