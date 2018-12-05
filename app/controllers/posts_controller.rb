class PostsController < ApplicationController
	before_action :set_post, 			only: [:like, :unlike]
	before_action :logged_in_user,	only: [:create, 
																				 :edit, 
																				 :update, 
																				 :destroy, 
																				 :like, 
																				 :unlike]
	before_action :correct_user,		only: [:edit, :update, :destroy]
	after_action  :modal_create,		only: :create
	after_action	:reply,						only: :create
	after_action  :repost,					only: :create

	def index
	end

	def show
		@post = Post.find(params[:id])
		respond_to do |format|
			format.html
			format.js
		end
	end

	def create
		@post = current_user.posts.build(post_params)
		@post.children = []
		if @post.save
			if !@post.parent_id.nil? 
				@notice = "reply"
				create_notification @post, @notice
			elsif !@post.reference_id.nil?
				@notice = "repost"
				create_notification @post, @notice
			end
			flash[:success] = "Post successfully sent"
			redirect_to root_url
		else
			@feed_items = []
			flash[:danger] = "There was an error processing your post"
			redirect_to root_url
		end
	end

	def modal_create
		@post = current_user.posts.new
		respond_to do |format|
			format.html
			format.js
		end
	end

	def edit
		@post = Post.find(params[:id])
		respond_to do |format|
			format.html
			format.js
		end
	end

	def update
		if @post.update_attributes(post_params)
			flash[:success] = "Post successfully updated"
			redirect_to root_url
		else
			flash[:danger] = "There was an error processing your post"
			redirect_to root_url
		end
	end

	def destroy
		@post.destroy
		flash[:success] = "Post deleted"
		redirect_to request.referrer || root_url
	end

	def like
		@post.liked_by current_user
		@notice = "like"
		create_notification @post, @notice 
		respond_to do |format|
			format.html { redirect_back fallback_location: root_path }
			format.js { render layout: false }
		end
	end

	def unlike
		@post.unliked_by current_user
		respond_to do |format|
			format.html { redirect_back fallback_location: root_path }
			format.js { render layout: false }
		end
	end

	def reply
		@post = current_user.posts.new
		@parent = Post.find_by(id: params[:parent_id])
		@post.parent_id = params[:parent_id]
		respond_to do |format|
			format.js
			format.html
		end
	end

	def repost
		@post = current_user.posts.new
		@reference = Post.find_by(id: params[:reference_id])
		@post.reference_id = params[:reference_id]
		respond_to do |format|
			format.js
			format.html
		end 
	end

	private

		def post_params
			params.require(:post).permit(:content, :picture, :parent_id, :reference_id)
		end

		def correct_user
			@post = current_user.posts.find_by(id: params[:id])
			redirect_to root_url if @post.nil?
		end

		def set_post
			@post = Post.find(params[:id])
		end

		def create_notification(post, notice)
			if notice == "reply"
				parent = Post.find_by(id: post.parent_id)
				Notification.create(user_id: parent.user_id,
														sender_id: current_user.id,
														post_id: parent.id,
														identifier: post.id,
														n_type: notice)
			elsif notice == "repost"
				reference = Post.find_by(id: post.reference_id)
				Notification.create(user_id: reference.user_id,
														sender_id: current_user.id,
														post_id: reference.id,
														identifier: post.id,
														n_type: notice)
			elsif notice == "like"
				Notification.create(user_id: post.user_id,
													  sender_id: current_user.id,
													  post_id: post.id,
													  identifier: post.id,
													  n_type: notice)
			end		
		end
end