$.Carousel = function (el) {
  this.activeIdx = 1;
  this.$el = $(el);
  this.numImgs = this.$el.find("ul").children().length;

  this.$right = $('.slide-right');
  this.$left = $('.slide-left');

  this.$right.on("click", this.slide.bind(this));
  this.$left.on("click", this.slide.bind(this));
};

$.Carousel.prototype.slide = function (event) {
  if (($(event.currentTarget).context.className) === "slide-right") {
    this.activeIdx += 1;
  } else {
    this.activeIdx -= 1;
  }
  if (this.activeIdx > this.numImgs) {
    this.activeIdx = 1;
  } else if (this.activeIdx < 0) {
    this.activeIdx = this.numImgs;
  }


  this.$el.find("li.active").toggleClass("active");

  var $newImg = this.$el.find("ul > li:nth-child(" + this.activeIdx + ")");
  $newImg.toggleClass("active");
}


$.fn.cats = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
