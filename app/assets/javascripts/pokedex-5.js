Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li.poke-list-item" : "selectPokemonFromList"
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon()
  },

  addPokemonToList: function (pokemon) {
    var content = JST["pokemonListItem"]({pokemon: pokemon})
    this.$el.append(content);
  },

  refreshPokemon: function (options) {
    this.collection.fetch( {
      success: function () {
        this.render();
      }.bind(this)
    })
  },

  render: function () {
    this.$el.empty();
    this.collection.each(function(pokemon) {
      this.addPokemonToList(pokemon);
    }.bind(this));
  },

  selectPokemonFromList: function (event) {
    var pokemonId = $(event.currentTarget).data('id');
    var pokemon = this.collection.get(pokemonId);

    var pokemonDetail = new Pokedex.Views.PokemonDetail({model: pokemon})
    $("#pokedex .pokemon-detail").html(pokemonDetail.$el);
    pokemonDetail.refreshPokemon();
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
  },

  refreshPokemon: function (options) {
  },

  render: function () {
    var content = JST["pokemonDetail"]({ pokemon: this.model })
    this.$el.html(content);
  },

  selectToyFromList: function (event) {
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
  }
});


$(function () {
  var pokemonIndex = new Pokedex.Views.PokemonIndex();
  pokemonIndex.refreshPokemon();
  $("#pokedex .pokemon-list").html(pokemonIndex.$el);
});
