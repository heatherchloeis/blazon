class Message < ApplicationRecord
	belongs_to :conversation
	belongs_to :user

	validates_presence_of :body, :conversation_id, :user_id

	def sent_at
		created_at.strftime("%I:%M %p - %d %b %Y")
	end
end