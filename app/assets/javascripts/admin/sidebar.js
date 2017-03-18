var toggleSidebar;
(toggleSidebar = function(){
  if (document.body.offsetWidth <= 1150) {
    $('.sidebar').addClass("collapse")
  } else {
    $('.sidebar').removeClass("collapse")
  }
})();

window.onresize = function() {
  toggleSidebar();
}
window.onresize();

$('.page-bg').click(function () {
  toggleSidebar();
})


