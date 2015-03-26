TrelloClone.Views.ListForm = Backbone.View.extend({
  initialize: function() {
  },

  template: JST["list_form"],

  tagName: "form",

  className: "list-form",

  events: {
    "submit": "createNewList"
  },

  createNewList: function(event) {
    event.preventDefault();
    var formData = $(event.target).serializeJSON();
    formData.list.board_id = this.collection.board.id

    
    var that = this;
    this.model.set(formData.list);
    this.model.save({}, {
      success: function() {
        that.collection.add(that.model, {merge:true});
      }
    });
  },

  render: function() {
    this.$el.html(this.template());
    return this;
  },


})
