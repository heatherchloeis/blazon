require 'test_helper'

class ChirpsControllerTest < ActionDispatch::IntegrationTest
	def setup
		@sender = users(:geralt)
		@recipient = users(:yen)
	end

	test "should redirect conversations when not logged in" do 
		get conversations_path
		assert_redirected_to login_url
	end
end
