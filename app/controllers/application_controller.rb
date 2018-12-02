class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	include SessionsHelper

  def search 
    @users = User.ransack(name_or_username_cont: params[:q]).result(distinct: true)
    respond_to do |format|
      format.html
      format.json {
        @users = @users.limit(5)
      }
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render file: 'public/404', status: :not_found
  end
  
	private
	
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end
end
