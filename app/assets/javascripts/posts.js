(function() {
	'use strict';

	this.Post = (function() {
		function Post() {}

		Post.add_atwho = function() {
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
		return Post;
	})();

	jQuery(function() {
		return Post.add_atwho();
	});

}).call(this);