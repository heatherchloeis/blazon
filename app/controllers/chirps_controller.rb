class ChirpsController < ApplicationController
	before_action :set_chirp, 			only: [:like, :unlike]
	before_action :logged_in_user,	only: [:create, 
																				 :edit, 
																				 :update, 
																				 :destroy, 
																				 :like, 
																				 :unlike]
	before_action :correct_user,		only: [:edit, :update, :destroy]
	after_action  :modal_create,		only: :create
	after_action	:reply,						only: :create
	after_action  :rechirp,					only: :create

	def index
	end

	def show
		@chirp = Chirp.find(params[:id])
		respond_to do |format|
			format.html
			format.js
		end
	end

	def create
		@chirp = current_user.chirps.build(chirp_params)
		@chirp.children = []
		if @chirp.save
			if !@chirp.parent_id.nil? 
				@notice = "reply"
				create_notification @chirp, @notice
			elsif !@chirp.reference_id.nil?
				@notice = "rechirp"
				create_notification @chirp, @notice
			end
			flash[:success] = "Chirp successfully sent"
			redirect_to root_url
		else
			@feed_items = []
			flash[:danger] = "There was an error processing your chirp"
			redirect_to root_url
		end
	end

	def modal_create
		@chirp = current_user.chirps.new
		respond_to do |format|
			format.html
			format.js
		end
	end

	def edit
		@chirp = Chirp.find(params[:id])
		respond_to do |format|
			format.html
			format.js
		end
	end

	def update
		if @chirp.update_attributes(chirp_params)
			flash[:success] = "Chirp successfully updated"
			redirect_to root_url
		else
			flash[:danger] = "There was an error processing your chirp"
			redirect_to root_url
		end
	end

	def destroy
		@chirp.destroy
		flash[:success] = "Chirp deleted"
		redirect_to request.referrer || root_url
	end

	def like
		@chirp.liked_by current_user
		@notice = "like"
		create_notification @chirp, @notice 
		respond_to do |format|
			format.html { redirect_back fallback_location: root_path }
			format.js { render layout: false }
		end
	end

	def unlike
		@chirp.unliked_by current_user
		respond_to do |format|
			format.html { redirect_back fallback_location: root_path }
			format.js { render layout: false }
		end
	end

	def reply
		@chirp = current_user.chirps.new
		@parent = Chirp.find_by(id: params[:parent_id])
		@chirp.parent_id = params[:parent_id]
		respond_to do |format|
			format.js
			format.html
		end
	end

	def rechirp
		@chirp = current_user.chirps.new
		@reference = Chirp.find_by(id: params[:reference_id])
		@chirp.reference_id = params[:reference_id]
		respond_to do |format|
			format.js
			format.html
		end 
	end

	private

		def chirp_params
			params.require(:chirp).permit(:content, :picture, :parent_id, :reference_id)
		end

		def correct_user
			@chirp = current_user.chirps.find_by(id: params[:id])
			redirect_to root_url if @chirp.nil?
		end

		def set_chirp
			@chirp = Chirp.find(params[:id])
		end

		def create_notification(chirp, notice)
			if notice == "reply"
				parent = Chirp.find_by(id: chirp.parent_id)
				Notification.create(user_id: parent.user_id,
														sender_id: current_user.id,
														chirp_id: parent.id,
														identifier: chirp.id,
														n_type: notice)
			elsif notice == "rechirp"
				reference = Chirp.find_by(id: chirp.reference_id)
				Notification.create(user_id: reference.user_id,
														sender_id: current_user.id,
														chirp_id: reference.id,
														identifier: chirp.id,
														n_type: notice)
			elsif notice == "like"
				Notification.create(user_id: chirp.user_id,
													  sender_id: current_user.id,
													  chirp_id: chirp.id,
													  identifier: chirp.id,
													  n_type: notice)
			end		
		end
end