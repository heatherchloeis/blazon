require 'test_helper'

class PostTest < ActiveSupport::TestCase
	def setup
		@user = users(:cirilla)
		@post = @user.posts.build(content: "Lorem ipsum")
	end

	test "post should be valid" do 
		assert @post.valid?
	end

	test "user id should be present" do
		@post.user_id = nil
		assert_not @post.valid?
	end

	test "content should be present" do
		@post.content = "     "
		assert_not @post.valid?
	end

	test "content should not exceed 250 char" do
		@post.content = "a" * 251
		assert_not @post.valid?
	end

	test "posts should be shown most recent first" do
		assert_equal posts(:most_recent), Post.first
	end
end
