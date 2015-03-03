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

  refreshPokemon: function (callback, options) {
    this.collection.fetch( {
      success: function () {
        this.render();
        callback && callback();

      }.bind(this)
    });
  },

  render: function () {
    this.$el.empty();
    this.collection.each(this.addPokemonToList.bind(this));
  },


  selectPokemonFromList: function (event) {
    var pokemonId = $(event.currentTarget).data('id');

    Backbone.history.navigate("pokemon/" + pokemonId,
      { trigger: true });
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click li.toy-list-item" : "selectToyFromList"
  },

  refreshPokemon: function (callback, options) {
    this.model.fetch( {
      success: function () {
        this.render();
        callback && callback();

      }.bind(this)
    });
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
    var pokemonId = toy.get("pokemon_id");

    Backbone.history.navigate("pokemon/" + pokemonId + "/toys/" + toyId,
      { trigger: true });

  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({

  events: {
    "change select" : "moveToy"
  },

  render: function () {
    var content = JST["toyDetail"]({toy: this.model, pokes: this.collection});
    this.$el.html(content);

    return this;
  },

  moveToy: function(event) {
    var oldPokemonId = $(event.currentTarget).data("pokemon-id");
    var toyId = $(event.currentTarget).data("toy-id");
    var newPokemonId = $(event.currentTarget).val();
    var oldPokemon = this.collection.get(oldPokemonId);

    this.model.save({pokemon_id: newPokemonId}, {
      success: function() {
        oldPokemon.toys().remove(this.model);
        // Backbone.history.navigate("pokemon/" + newPokemonId, { trigger: true});
        Backbone.history.navigate("pokemon/" + newPokemonId + "/toys/" + toyId,
          { trigger: true });

      }
    });
  }
});


// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
