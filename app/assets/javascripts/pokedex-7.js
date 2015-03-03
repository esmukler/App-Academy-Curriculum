Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
  },

  render: function () {
    var content = JST["pokemonForm"]();
    this.$el.html(content);
  },

  savePokemon: function (event) {
  }
});
