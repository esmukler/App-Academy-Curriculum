Function.prototype.myBind = function (context) {
  var fn = this;

  return (function () {
    return(fn.apply(context));
  });
};

var cat = {
  name: "Sennacy",
  sayHi: function () {
    return "meow my name is " + this.name;
  },
  addTwoNums: function (num1, num2) {
    return this.name + " says this is the sum: " + (num1 + num2);
  }
};

var dog = {
  name: "Skin Folds"
};

var dogHi = cat.sayHi.myBind(dog);
console.log("myBind " + dogHi()); //=> "Skin Folds ... "

console.log("bind: " + cat.sayHi.bind(dog)());
console.log("myBind: " + cat.sayHi.myBind(dog)());
