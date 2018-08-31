require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase

	def setup
		@relationship = Relationship.new(follower_id: users(:triss).id,
																		 followed_id: users(:cirilla).id)
	end

	test "relationship should be valid" do 
		assert @relationship.valid?
	end

	test "relationship should require a follower_id" do 
		@relationship.follower_id = nil
		assert_not @relationship.valid?
	end

	test "relationship should require a followed_id" do
		@relationship.followed_id = nil
		assert_not @relationship.valid?
	end
end
