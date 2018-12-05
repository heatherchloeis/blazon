require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:cirilla)
		@post = posts(:two)
		log_in_as(@user)
	end

	test "post interface" do 
		get root_path
		assert_select 'div.pagination'
		assert_select 'input[type=file]'
		# Try invalid submission
		assert_no_difference 'Post.count' do
			post posts_path, params: { post: { content: "" } }
		end
		# Try valid submission
		content = "This post is a test post."
		picture = fixture_file_upload('test/fixtures/test_picture.png', 'image/png')
		assert_difference 'Post.count', 1 do
			post posts_path, params: { post: { content: content, picture: picture } }
		end
		assert @user.posts.first.picture?
		assert_redirected_to root_url
		follow_redirect!
		# Try to reply to post
		assert_select 'a[href=?]', reply_post_path(@user, parent_id: @post.id)
		assert_difference 'Post.count', 1 do
			get reply_post_path(@user, parent_id: @post), xhr: true
			post posts_path, params: { post: { content: content, parent_id: @post.id } }
			assert :success
		end
		assert_redirected_to root_url
		follow_redirect!
		assert_select 'p.post-context', text: "Replying to @#{@post.user.username}"
		# Try to repost post
		assert_select 'a[href=?]', repost_post_path(@user, reference_id: @post.id)
		assert_difference 'Post.count', 1 do
			get repost_post_path(@user, reference_id: @post), xhr: true
			post posts_path, params: { post: { content: content, reference_id: @post.id } }
			assert :success
		end
		assert_redirected_to root_url
		follow_redirect!
		assert_select 'small.post-context', text: "You
 Retweeted"
 		# Try to like post and then unlike post
 		assert_select 'a[href=?]', like_post_path(@post)
 		assert_difference '@post.votes_for.up.by_type(User).count', 1 do
 			put like_post_path(@post)
 			assert :success
 		end
		assert_redirected_to root_url
		follow_redirect!
		assert_select 'a[href=?]', unlike_post_path(@post)
 		assert_difference '@post.votes_for.up.by_type(User).count', -1 do
 			put unlike_post_path(@post)
 			assert :success
 		end
		assert_redirected_to root_url
		follow_redirect!
		# Try delete post
		first_post = @user.posts.paginate(page: 1).first 
		assert_select 'div.post-content > div.dropdown-menu > a.dropdown-item', text: 'Edit post'
		assert_select 'div.post-content > div.dropdown-menu > a.dropdown-item', text: 'Delete post'
		assert_difference 'Post.count', -1 do
			delete post_path(first_post)
		end
		# Try visit other user
		get user_path(users(:triss))
		assert_select 'a.dropdown-item', text: 'delete post', count: 0
	end
end
