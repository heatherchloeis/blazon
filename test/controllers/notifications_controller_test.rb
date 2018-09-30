require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:cirilla)
		@chirp = chirps(:two)
		@other_user = users(:triss)
		@chirp.liked_by @user
	end

  test "should update notification status" do
  	log_in_as @other_user
  	get root_path
  end
end
