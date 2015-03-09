TrelloClone.Views.BoardIndex = Backbone.View.extend({
  initialize: function() {
    // this._subviews = [];
    this.listenTo(this.collection, "sync", this.render);
  },

  template: JST["board_index"],


  className: "all-boards",

  events: {
    "click button.new-board": "newBoard"
  },

  newBoard: function(event) {
    var formView = new TrelloClone.Views.BoardForm({
      collection: this.collection
    });
    // this._subviews.push(formView);

    this.$el.append(formView.render().$el);
  },

  render: function() {
    this.$el.html(this.template({boards: this.collection}));
    return this;
  },

  // remove: function() {
  //   this._subViews
  // }

})
