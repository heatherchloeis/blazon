(function() {
	'use strict';

	this.Chirp = (function() {
		function Chirp() {}

		Chirp.add_atwho = function() {
			return $(.chirp-content).atwho({
				at: '@',
				displayTpl: "<li class='mention-item' data-value='(${name}, ${username})'>${name} @${username}</li>",
				callbacks: {
					remoteFilter: function(query, callback) {
						if (query.length < 1) {
							return false;
						} else {
							return $.getJSON('/mentions', {
								q: query
							}, function(data) {
								return callback(data);
							});
						}
					}
				}
			})
		}
		return Chirp;
	})();

	jQuery(function() {
		return Chirp.add_atwho();
	});

}).call(this);