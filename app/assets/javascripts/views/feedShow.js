NewsReader.Views.FeedShow = Backbone.View.extend({
  initialize: function(options) {
    this.model = options.model;

    this.listenTo(this.model, "sync", this.render);
  },

  template: JST['feed_show'],

  // tagName: 'div',

  className: 'feed-show',

  render: function() {
    console.log("show render");
    this.$el.html(this.template({feed: this.model}));
    return this;
  }

})
