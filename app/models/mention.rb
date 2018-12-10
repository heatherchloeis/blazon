class Mention < ApplicationRecord
	attr_reader :mentionable
	include Rails.application.routes.url_helpers

	def self.all(letters)
		return Mention.none unless letters.present?
		users = User.where('username LIKE ?', "#{letters}%").limit(5).compact
		users.map do |user|
			{ name: user.name, username: user.name }
		end
	end

	def self.create_from_text(post)
		potential_matches = post.content.scan(/@\w+/i)
		potential_matches.uniq.map do |match|
			mention = Mention.create_from_match(match)
			next unless mention
			post.update_attributes!(content: mention.markdown_string(post.content))
			mention
		end.compact
	end

	def self.create_from_match(match)
		user = User.find_by(username: match.delete('@'))
		UserMention.new(user) if user.present?
	end

	def initialize(mentionable)
		@mentionable = mentionable
	end

	class UserMention < Mention
		def markdown_string(text)
			host = Rails.env.development? ? 'localhost:3000' : 'blazon.herokuapp.com'
			text.gsub(/@#{mentionable.username}/i,
								"[**@#{mentionable.username}**](#{user_url(mentionable, host: host)})")
		end
	end
end