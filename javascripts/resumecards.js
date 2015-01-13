$(document).ready(function () {

  var $body = $('body');
  var $nav = $('nav');
  var $header = $('header');
  var $themeMenu = $('.resume-dropdown-menu > li > a');

  $nav.affix({
    offset: {
      top: $header.outerHeight()
    }
  });

  $nav.on('affix.bs.affix', function (){
    $body.css('margin-top', $nav.height() + parseInt($nav.css('margin-bottom')));
  });

  $nav.on('affix-top.bs.affix', function (){
    $body.css('margin-top', 0);
  });

  $themeMenu.on('click', function(event) {

    $body.attr('class', '');

    var themeColor = $(this).attr('id');
    var themeColorClass = "theme-" + themeColor;
    $body.addClass(themeColorClass);

    event.preventDefault();

  });

});
