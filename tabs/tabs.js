$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = this.$el.find(".data-content-tabs");
  this.$activeTab = this.$el.find(".tab-pane.active");
  this.clickTab();
};

$.Tabs.prototype.clickTab = function () {
  var tab = this;
  this.$contentTabs.on("click", "a", function (event) {
    event.preventDefault();

    tab.$contentTabs.find(".active").toggleClass();
    $(event.currentTarget).toggleClass("active");
    tab.$activeTab.toggleClass("transitioning");

    var id = event.currentTarget.hash;
    tab.$activeTab.one("transitionend", function (event) {
      $(this).toggleClass("transitioning active");
      tab.$activeTab = $(tab.$el.find(id));
      tab.$activeTab.toggleClass("active transitioning");
      setTimeout(function () {
        tab.$activeTab.toggleClass("transitioning");
      }, 0);
    })
  })
}

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
