

var Cat = function(name, owner){
  this.name = name;
  this.owner = owner;
};

Cat.prototype.cuteStatement = function() {
  console.log("Everyone loves " + this.name);
};

Cat.prototype.mean = function() {
  console.log("Everyone hates " + this.name);
};
