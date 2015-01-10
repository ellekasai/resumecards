$(document).ready(function () {

  $('nav').affix({
    offset: {
      top: $('header').height()
    }
  });

  $('nav').on('affix.bs.affix', function (){
    $('body').css('margin-top', $('nav').height());
  });

  $('nav').on('affix-top.bs.affix', function (){
    $('body').css('margin-top', 0);
  });

});
