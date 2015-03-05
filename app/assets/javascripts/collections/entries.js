NewsReader.Collections.Entries = Backbone.Collection.extend({
  url: function () {
    return this.feed.url() + '/entries';
  }.bind(this),
  model: NewsReader.Models.Entry,


})
