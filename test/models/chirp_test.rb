require 'test_helper'

class ChirpTest < ActiveSupport::TestCase
	def setup
		@user = users(:cirilla)
		@chirp = @user.chirps.build(content: "Lorem ipsum")
	end

	test "chirp should be valid" do 
		assert @chirp.valid?
	end

	test "user id should be present" do
		@chirp.user_id = nil
		assert_not @chirp.valid?
	end

	test "content should be present" do
		@chirp.content = "     "
		assert_not @chirp.valid?
	end

	test "content should not exceed 250 char" do
		@chirp.content = "a" * 251
		assert_not @chirp.valid?
	end

	test "chirps should be shown most recent first" do
		assert_equal chirps(:most_recent), Chirp.first
	end
end
