Pokedex.Router = Backbone.Router.extend({
  routes: {
    "" : "pokemonIndex",
    "index": "pokemonIndex",
    "pokemon/:id" : "pokemonDetail",
    "pokemon/:pokemonId/toys/:toyId" : "toyDetail"
  },

  pokemonDetail: function (id, callback) {
    if (!this._pokemonIndex) {
      this.pokemonIndex(this.pokemonDetail.bind(this, id, callback));
      return;
    }

    var pokemon = this._pokemonIndex.collection.get(id);
    var pokemonDetail = new Pokedex.Views.PokemonDetail({model: pokemon})
    this._pokemonDetail = pokemonDetail;
    pokemonDetail.refreshPokemon(callback);
    $("#pokedex .pokemon-detail").html(pokemonDetail.$el);

  },

  pokemonIndex: function (callback) {
    var pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex = pokemonIndex;
    pokemonIndex.refreshPokemon(callback);
    $("#pokedex .pokemon-list").html(pokemonIndex.$el);
    this.pokemonForm();
  },

  toyDetail: function (pokemonId, toyId) {
    if (!this._pokemonDetail) {
      this.pokemonDetail(pokemonId, this.toyDetail.bind(this, pokemonId, toyId));
      return;
    };

    var pokemon = this._pokemonDetail.model;
    var toy = pokemon.toys().get(toyId);
    var toyDetail = new Pokedex.Views.ToyDetail({model: toy});

    $("#pokedex .toy-detail").html(toyDetail.$el);
    toyDetail.render();
  },

  pokemonForm: function () {
    var newPokemon = new Pokedex.Models.Pokemon();
    var pokemonForm = new Pokedex.Views.PokemonForm({
              model: newPokemon, collection: this._pokemonIndex.collection});
    $('#pokedex .pokemon-form').html(pokemonForm.$el);
    pokemonForm.render();
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
