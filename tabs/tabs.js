$.Tabs = function (el) {
  


};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
