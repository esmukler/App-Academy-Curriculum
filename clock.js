// var setInterval = require("sdk/timers");

function Clock() {
};

Clock.prototype.printTime = function() {
  var hours = this.currentTime.getHours();
  var mins  = this.currentTime.getMinutes();
  var secs  = this.currentTime.getSeconds();

  console.log(hours + ":" + mins + ":" + secs)
};

Clock.prototype.run = function() {
  var clock = this;
  this.currentTime = new Date();

  this.printTime();
  setInterval( function() {
    clock._tick();
  }, 5000 )
};

Clock.prototype._tick = function() {
  this.currentTime.setSeconds(this.currentTime.getSeconds() + 5);
  this.printTime();
};

var clock = new Clock();
clock.run();
