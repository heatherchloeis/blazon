class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:index, 
                                         :edit, 
                                         :update, 
                                         :destroy,
                                         :following,
                                         :followers]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end
	
  def show
		@user = User.friendly.find(params[:id])
    redirect_to root_url and return unless @user.activated?
    @chirps = @user.chirps.paginate(page: params[:page])
	end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		# Handle successful save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account"
      redirect_to root_url
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.friendly.find(params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User successfully deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.friendly.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.friendly.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def liked_chirps
    @title = "Liked chirps"
    @user = User.friendly.find(params[:id])
    @chirps = @user.find_liked_items
    render 'show_likes'
  end

  def mentions
    respond_to do |format|
      format.json { render :jsn => Mention.all(params[:q]) }
    end
  end

  def format_birthdate
    @user = User.friendly.find(params[:id])
    birthdate = @user.birthdate.split("/")
  end

  private

  	def user_params
  		params.require(:user).permit(:name, 
  																 :email, 
                                   :username,
  																 :password, 
  																 :password_confirmation,
                                   :avatar,
                                   :cover)
  	end

    def correct_user
      @user = User.friendly.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
