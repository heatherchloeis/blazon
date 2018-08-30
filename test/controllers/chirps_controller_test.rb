require 'test_helper'

class ChirpsControllerTest < ActionDispatch::IntegrationTest
	def setup
		@chirp = chirps(:two)
	end

	test "should redirect create when not logged in" do 
		assert_no_difference 'Chirp.count' do
			post chirps_path, params: { chirp: { content: "Lorem ipsum" } } 
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy when not logged in" do
		assert_no_difference 'Chirp.count' do
			delete chirp_path(@chirp)
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy for wrong chirp" do
		log_in_as(users(:cirilla))
		assert_no_difference 'Chirp.count' do
			delete chirp_path(@chirp)
		end
		assert_redirected_to root_url
	end
end
