TrelloClone.Views.CardForm = Backbone.View.extend({
  initialize: function() {
  },

  template: JST["card_form"],

  tagName: "form",

  className: "card-form",

  events: {
    "submit": "createNewForm"
  },

  createNewForm: function(event) {
    event.preventDefault();
    var formData = $(event.target).serializeJSON();
    formData.card.list_id = this.collection.list.id

    var that = this;
    this.model.set(formData.card);
    this.model.save({}, {
      success: function() {
        console.log("successful card model save")
        that.collection.add(that.model, {merge: true});
      }
    })
  },

  render: function() {
    this.$el.html(this.template());
    return this;
  },


})
