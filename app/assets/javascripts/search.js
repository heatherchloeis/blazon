(function() {
	"use strict";

	document.addEventListener("turbolinks:load", function() {
		var input = $(".search[data-behavior='autocomplete']")

		var options = {
			getValue: "user",
			url: function(phrase) {
				return "/search.json?q=" + phrase;
			},
			categories: [
				{

					listLocation: "users",
				}
			],
			list: {
				onChooseEvent: function() {
					var url = input.getSelectedItemData().url;
					console.log(url);
					input.val("");
					Turbolinks.visit(url);
				}
			},
			highlightPhrase: false,
			theme: "blue-light"
		}

		input.easyAutocomplete(options);
	});
})();