require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
	def setup
		@post = posts(:two)
		@user = users(:cirilla)
	end

	test "should redirect create when not logged in" do
		assert_no_difference 'Post.count' do
			post posts_path, params: { post: { content: "Lorem ipsum" } } 
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy when not logged in" do
		get post_path(@post.id)
		assert_no_difference 'Post.count' do
			delete post_path(@post)
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy for wrong post" do
		log_in_as(@user)
		get post_path(@post.id)
		assert_no_difference 'Post.count' do
			delete post_path(@post)
		end
		assert_redirected_to root_url
	end
end
