NewsReader.Views.FeedIndex = Backbone.View.extend({
  initialize: function(options) {
    this.collection = options.collection;

    this.listenTo(this.collection, "sync destroy", this.render)
  },

  events: {
    "click button.destroy-feed": "deleteFeed",
    "submit form.new-feed" : "newFeed"
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
  },

  newFeed: function (event) {
    $notice = this.$el.find("div#notice")
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON();
    this.collection.create(formData.feed, {
      success: function () {
        $notice.html("Successfully created feed");
      },

      error: function () {
        $notice.html("Not a valid URL");
      },

      wait: true
    });
  }

})
