class Chirp < ApplicationRecord
  belongs_to :user

  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 250 }
  validate 	:picture_size

  acts_as_votable

  private

  	# Validates the size of an uploaded picture
  	def picture_size
  		if picture.size > 5.megabytes
  			errors.add(:picture, "Pictures cannot be greater than 5MB")
  		end
  	end
end
