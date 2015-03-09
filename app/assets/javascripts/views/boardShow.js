TrelloClone.Views.BoardShow = Backbone.View.extend({
  initialize: function() {
    this._subViews = [];
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.lists(), "add remove sync", this.render);
  },

  template: JST["board_show"],


  className: "board-container",

  events: {
    "click button.new-list": "newList",
    "click button.index" : "goToIndex",
    "click button.delete-board": "deleteBoard",
    "sortupdate .lists": "updateOrder"
  },

  render: function(newOrder) {
    this.$el.html(this.template({ board: this.model }));
    var $lists = $(".lists");
    $lists.sortable()

    var lists = this.model.lists();

    lists.sort()

    lists.each(function(list) {
      var listShow = new TrelloClone.Views.ListShow({ model: list });
      $lists.append(listShow.render().$el)
      this._subViews.push(listShow);
    }.bind(this))

    return this;
  },

  updateOrder: function(event, ui) {
    var newOrder = [];
    var $children = $($(event.currentTarget).children())
    for (var i = 0; i< $children.length; i++) {
      newOrder.push($($children[i]).attr("data-id"));
    }

    var lists = this.model.lists();

    if (newOrder) {
      for (var j = 0; j < newOrder.length; j++) {
        lists.each(function(list) {
          if (newOrder[j] == list.id) {
            list.save({ord: j})
          }
        })
      }
    }
    this.render();
  },

  newList: function(event) {
    var newList = new TrelloClone.Models.List()

    var listForm = new TrelloClone.Views.ListForm({
      collection: this.model.lists(),
      model: newList
    })
    var $button = $(event.currentTarget);
    $button.after(listForm.render().$el);
  },

  goToIndex: function() {
    Backbone.history.navigate("boards", {trigger: true});
  },

  deleteBoard: function() {
    this.model.destroy({
      success: this.goToIndex
    });
  },

  remove: function() {
    if(this._subViews) {
      for (var i = 0; i< this._subViews.length; i++) {
        this._subViews[i].remove();
        this._subViews.splice(i, 1);
      }
    }
    Backbone.View.prototype.remove.call(this)
  }


})
