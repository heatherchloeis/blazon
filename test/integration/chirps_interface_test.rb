require 'test_helper'

class ChirpsInterfaceTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:cirilla)
	end

	test "chirp interface" do 
		log_in_as(@user)
		get root_path
		assert_select 'div.pagination'
		assert_select 'input[type=file]'
		# Try invalid submission
		assert_no_difference 'Chirp.count' do
			post chirps_path, params: { chirp: { content: "" } }
		end
		assert_select 'div#error_explanation'
		# Try valid submission
		content = "This chirp is a test chirp."
		picture = fixture_file_upload('test/fixtures/test_picture.png', 'image/png')
		assert_difference 'Chirp.count', 1 do
			post chirps_path, params: { chirp: { content: content, picture: picture } }
		end
		assert @user.chirps.first.picture?
		assert_redirected_to root_url
		follow_redirect!
		# Try delete chirp
		assert_select 'a', text: 'delete'
		first_chirp = @user.chirps.paginate(page: 1).first 
		assert_difference 'Chirp.count', -1 do
			delete chirp_path(first_chirp)
		end
		# Try visit other user
		get user_path(users(:triss))
		assert_select 'a', text: 'delete', count: 0
	end

	# test "chirp sidebar count" do
	# 	log_in_as(@user)
	# 	get root_path
	# 	assert_match Chirp.count, response.body
	# end
end
