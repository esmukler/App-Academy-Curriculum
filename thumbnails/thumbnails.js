$.Thumbnails = function (el) {
  this.$el = $(el);
  this.$activeImg = $('.gutter-images > li:first-child').children();
  this.$tempImg = null;
  this.activate();
  this.$el.find('.gutter-images').on('click', 'img', this.selectImage.bind(this))
  this.$el.find('.gutter-images').on('mouseenter', 'img', this.hoverSelect.bind(this))
  this.$el.find('.gutter-images').on('mouseleave', 'img', this.activate.bind(this))

};

$.Thumbnails.prototype.activate = function() {
  var source = this.$activeImg.attr('src');
  $('.active:first-child').children().attr('src', source);
}

$.Thumbnails.prototype.selectImage = function(event) {
  this.$activeImg = $(event.currentTarget);
  this.activate();
}

$.Thumbnails.prototype.hoverSelect = function(event) {
  this.$tempImg = $(event.currentTarget);
  var source = this.$tempImg.attr('src');
  $('.active:first-child').children().attr('src', source);
}

$.fn.thumbs = function () {
  return this.each(function () {
    new $.Thumbnails(this);
  });
};
