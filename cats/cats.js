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
  var rightIdx = this.activeIdx + 1;
  var leftIdx = this.activeIdx - 1;

  // wrapping
  if (this.activeIdx > this.numImgs) {
    this.activeIdx = 0;
    rightIdx = 1;
  } else if (this.activeIdx < 0) {
    leftIdx = this.numImgs - 1;
    this.activeIdx = this.numImgs;
  } else if (rightIdx > this.numImgs) {
    rightIdx = 0;
  } else if (leftIdx < 0) {
    leftIdx = this.numImgs;
  }


  if (dir === 1) {
    this.$el.find("li.active.left").removeClass("active left")
    var $rightImg = this.$el.find("ul > li").eq(rightIdx);
    $rightImg.addClass("active right");

    var $newImg = this.$el.find("ul > li").eq(this.activeIdx);

    var $leftImg = this.$el.find("ul > li").eq(leftIdx);

    $leftImg.addClass("left");
    $newImg.removeClass("right");


  } else {
    this.$el.find("li.active.right").removeClass("active right")
    var $leftImg = this.$el.find("ul > li").eq(leftIdx);
    $leftImg.addClass("active left");

    var $newImg = this.$el.find("ul > li").eq(this.activeIdx);

    var $rightImg = this.$el.find("ul > li").eq(rightIdx);
    $rightImg.addClass("right");


    $newImg.removeClass("left");;
  }

  console.log($("li"))
}



$.fn.cats = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
