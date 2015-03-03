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
    "click li.toy-list-item" : "selectToyFromList"
  },

  refreshPokemon: function (options) {
    this.model.fetch({
      success: this.render.bind(this)
    })
  },

  render: function () {
    var content = JST["pokemonDetail"]({ pokemon: this.model })
    this.$el.html(content);

    this.model.toys().each(function (toy) {
      var toyContent = JST["toyListItem"]({ toy: toy });
      this.$el.append(toyContent);
    }.bind(this))

    return this;
  },

  selectToyFromList: function (event) {
    var toyId = $(event.currentTarget).data('id');
    var toy = this.model.toys().get(toyId);

    var toyDetail = new Pokedex.Views.ToyDetail({model: toy});
    $("#pokedex .toy-detail").html(toyDetail.$el);
    toyDetail.render();
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    console.log(this.model);
    var pokes = new Pokedex.Collections.Pokemon();
    var content = JST["toyDetail"]({toy: this.model, pokes: pokes});
    this.$el.html(content);

    return this;
  }
});


$(function () {
  var pokemonIndex = new Pokedex.Views.PokemonIndex();
  pokemonIndex.refreshPokemon();
  $("#pokedex .pokemon-list").html(pokemonIndex.$el);
});
