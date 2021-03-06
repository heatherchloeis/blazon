class Post < ApplicationRecord
  belongs_to :user

  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader

  validates :user_id,   presence: true
  validates :content,   presence: true, length: { maximum: 250 }
  validate 	:picture_size

  acts_as_votable

  has_ancestry

  belongs_to :parent,       class_name: 'Post', optional: true
  has_many   :children,     class_name: 'Post'

  has_one    :reference,    class_name: 'Post'
  has_many   :referrals,    class_name: 'Post'
  
  has_many :notifications, dependent: :destroy

  after_create :add_mentions

  def add_mentions
    Mention.create_from_text(self)
  end

  private

  	# Validates the size of an uploaded picture
  	def picture_size
  		if picture.size > 5.megabytes
  			errors.add(:picture, "Image Uploads cannot be greater than 5MB")
  		end
  	end
end