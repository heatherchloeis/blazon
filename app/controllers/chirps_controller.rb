class ChirpsController < ApplicationController
	before_action :set_chirp, 			only: [:like, :unlike]
	before_action :logged_in_user,	only: [:create, :destroy, :like, :unlike]
	before_action :correct_user,		only: [:destroy]

	def create
		@chirp = current_user.chirps.build(chirp_params)
		if @chirp.save
			flash[:success] = "Chirp successfully sent"
			redirect_to root_url
		else
			@feed_items = []
			render 'static_pages/home'
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