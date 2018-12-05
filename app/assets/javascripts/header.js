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
});