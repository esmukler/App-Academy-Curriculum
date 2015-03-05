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
    this.$el.html(this.template({feed: this.model, entries: entries}));

    var $ul = this.$el.find('ul.entries-list');

    var entries = this.model.entries();
    if (entries.models.length > 0 ) {
      console.log("Entries", entries)
      entries.each(function(entry) {
        var entryView = new NewsReader.Views.FeedEntry({ model: entry });
        $ul.prepend(entryView.render().$el);
      });
    }

    return this;
  },

  reRender: function () {
    this.model.fetch()
  }
})
