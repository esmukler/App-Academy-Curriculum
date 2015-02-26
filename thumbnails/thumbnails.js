$.Thumbnails = function (el) {
  this.$el = $(el);
  this.$activeImg = $('.gutter-images > li:first-child').children();
  this.activate();
};

$.Thumbnails.prototype.activate = function() {
  var source = this.$activeImg.attr('src');
  $('.active:first-child').children().attr('src', source);

}


$.fn.thumbs = function () {
  return this.each(function () {
    new $.Thumbnails(this);
  });
};
