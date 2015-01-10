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

});
