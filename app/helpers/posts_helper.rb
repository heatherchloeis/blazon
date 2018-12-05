module PostsHelper
	def display_liked_by(post)
		votes = post.votes_for.up.by_type(User)
		return liked_by(votes) if votes.size <= 8
		count_liked_by(votes)
	end

	def liked_by(votes)
		usernames = []
		unless votes.blank?
			votes.voters.each do |voter|
				usernames.push(link_to voter.username, voter, class: "post-likes")
			end
			usernames.to_sentence.html_safe + like_plural(votes)
		end
	end

	def count_liked_by(votes)
		vote_count = votes.size
		vote_count.to_s + ' likes'
	end

	def count_reposts(post) 
		return Post.where(reference_id: post.id).count if Post.where(reference_id: post.id).count > 0
	end

	private

		def like_plural(votes)
			return ' like this' if votes.count > 1
			' likes this'
		end
end
