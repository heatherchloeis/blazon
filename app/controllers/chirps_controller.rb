class ChirpsController < ApplicationController
	before_action :set_chirp, 			only: [:like, :unlike]
	before_action :logged_in_user,	only: [:create, 
																				 :edit, 
																				 :update, 
																				 :destroy, 
																				 :like, 
																				 :unlike]
	before_action :correct_user,		only: [:edit, :update, :destroy]

	def create
		if [:chirp][:parent_id].present?
			@parent = Chirp.find(params[:parent_id])
			@parent.children.build(chirp_params)
		else
			@chirp = current_user.chirps.build(chirp_params)
		end
		if @chirp.save
			flash[:success] = "Chirp successfully sent"
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end

	def edit
		@chirp = Chirp.find(params[:id])
	end

	def update
		if @chirp.update_attributes(chirp_params)
			flash[:success] = "Chirp updated"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		@chirp.destroy
		flash[:success] = "Chirp deleted"
		redirect_to request.referrer || root_url
	end

	def like
		@chirp.liked_by current_user
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

	def new
	end

	private

		def chirp_params
			params.require(:chirp).permit(:content, :picture)
		end

		def correct_user
			@chirp = current_user.chirps.find_by(id: params[:id])
			redirect_to root_url if @chirp.nil?
		end

		def set_chirp
			@chirp = Chirp.find(params[:id])
		end
end