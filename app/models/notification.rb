class Notification < ApplicationRecord
	belongs_to :sender, class_name: "User"
	belongs_to :user
	belongs_to :post, optional: true
	belongs_to :conversation, optional: true

	validates  :user_id, :sender_id, :identifier, :n_type, presence: true
end
