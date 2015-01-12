$(document).ready(function () {

  $('nav').affix({
    offset: {
      top: $('header').outerHeight()
    }
  });

  $('nav').on('affix.bs.affix', function (){
    $('body').css('margin-top', $('nav').height() + parseInt($('nav').css('margin-bottom')));
  });

  $('nav').on('affix-top.bs.affix', function (){
    $('body').css('margin-top', 0);
  });

  var themeMenu = $('.resume-dropdown-menu > li > a');

  themeMenu.on('click', function() {
    event.preventDefault();
    var themeColor = $(this).attr('id');
    console.log(themeColor);
    var themeColorClass = "theme-" + themeColor;
    console.log(themeColorClass);
    $('body').addClass(themeColorClass);
  });

});
