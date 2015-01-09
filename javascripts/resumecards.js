$(document).ready(function () {

  var resumeNav = $('.resume-nav');
  var origOffsetY = resumeNav.offset().top;

  function scroll() {
    if ($(window).scrollTop() > origOffsetY) {
      $('.resume-nav').addClass('nav-fixed');
      $('.resume-content').addClass('nav-padding');
    } else {
      $('.resume-nav').removeClass('nav-fixed');
      $('.resume-content').removeClass('nav-padding');
    }
  }

  document.onscroll = scroll;

});
