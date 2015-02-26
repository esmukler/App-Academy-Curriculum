$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.attr("data-content-tabs"));
  this.$activeTab = this.$contentTabs.find(".tab-pane.active");
  this.$el.on("click", "a", this.clickTab.bind(this));
};

$.Tabs.prototype.clickTab = function (event) {
  event.preventDefault();

  this.$el.find(".active").toggleClass();
  $(event.currentTarget).toggleClass("active");
  this.$activeTab.toggleClass("transitioning");

  var id = event.currentTarget.hash;

  this.$activeTab.one("transitionend", function (event) {
    $(event.currentTarget).toggleClass("transitioning active");
    this.$activeTab = $(this.$contentTabs.find(id));
    this.$activeTab.toggleClass("active transitioning");


    setTimeout(function () {
      this.$activeTab.toggleClass("transitioning");
    }.bind(this), 0);
    
  }.bind(this))
}

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
