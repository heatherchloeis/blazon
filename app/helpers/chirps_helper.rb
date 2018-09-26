module ChirpsHelper
	def display_liked_by(chirp)
		votes = chirp.votes_for.up.by_type(User)
		return liked_by(votes) if votes.size <= 8
		count_liked_by(votes)
	end

	def liked_by(votes)
		usernames = []
		unless votes.blank?
			votes.voters.each do |voter|
				usernames.push(link_to voter.username, voter, class: "chirp-likes")
			end
			usernames.to_sentence.html_safe + like_plural(votes)
		end
	end

	def count_liked_by(votes)
		vote_count = votes.size
		vote_count.to_s + ' likes'
	end

	def count_rechirps(chirp) 
		return Chirp.where(reference_id: chirp.id).count if Chirp.where(reference_id: chirp.id).count > 0
	end

	private

		def like_plural(votes)
			return ' like this' if votes.count > 1
			' likes this'
		end
end
