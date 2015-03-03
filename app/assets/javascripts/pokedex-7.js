Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    "submit form.new-pokemon" : "savePokemon"
  },

  render: function () {
    var content = JST["pokemonForm"]();
    this.$el.html(content);
  },

  savePokemon: function (event) {
    event.preventDefault();
    var attrs = $(event.currentTarget).serializeJSON().pokemon;
    this.model.save(attrs, {
      success: function() {
        this.model = this.collection.add(this.model);
        console.log(this.collection);
        Backbone.history.navigate("pokemon/" + this.model.get("id"), { trigger: true });
      }.bind(this)
    });

  }
});
