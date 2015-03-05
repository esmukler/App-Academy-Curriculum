NewsReader.Views.FeedShow = Backbone.View.extend({
  initialize: function(options) {
    this.model = options.model;

    this.listenTo(this.model, "sync", this.render);
  },

  template: JST['feed_show'],

  className: 'feed-show',

  events: {
    "click button.refresh" : "reRender"
  },

  render: function() {
    console.log(this.model);
    this.$el.html(this.template({feed: this.model}));
    return this;
  },

  reRender: function () {
    this.model.fetch()
  }
})
