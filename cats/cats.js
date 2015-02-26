$.Carousel = function (el) {
  this.activeIdx = 0;
  this.$el = $(el);
  this.numImgs = this.$el.find("ul").children().length - 1;

  this.$right = $('.slide-right');
  this.$left = $('.slide-left');

  this.$right.on("click", this.slide.bind(this, 1));
  this.$left.on("click", this.slide.bind(this, -1));
};

$.Carousel.prototype.slide = function (dir) {
  this.activeIdx += dir;
  if (this.activeIdx > this.numImgs) {
    this.activeIdx = 0;
  } else if (this.activeIdx < 0) {
    this.activeIdx = this.numImgs;
  }


  this.$el.find("li.active").removeClass("active");

  var $newImg = this.$el.find("ul > li").eq(this.activeIdx);
  $newImg.addClass("active");
}


$.fn.cats = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
