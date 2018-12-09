$(document).ready(function() {
  $(".dark-icon").mouseenter(function() {
      $(".light-icon").show();
      $(".dark-icon").hide();
      $(this).hide();
  });

  $(".light-icon").mouseout(function() {
    $(".dark-icon").show();
    $(".light-icon").hide();
    $(this).hide();
  });

  $(window).on('load resize', function() {

    if ($(window).width() >= 675 ) {
      $("#header").show();
      $("#header_mobile").hide();
    } else {
      $("#header").hide();
      $("#header_mobile").show();
    }
  });
});