(function() {
	$(document).on("ready page:load", function() {
	  $('.alert').slideDown(500).delay(3000).slideUp(500);
	  $('#error_explanation').slideDown(500).delay(3000).slideUp(500);
	});
})();