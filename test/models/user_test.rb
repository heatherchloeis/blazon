require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: "Jane Doe", 
										 email: "janedoe@geemail.com",
										 username: "jane_doe",
										 password: "canarycanary",
										 password_confirmation: "canarycanary")
	end

	test "user should be valid" do
		assert @user.valid?
	end

	test "user name should be present" do 
		@user.name = "     "
		assert_not @user.valid?
	end

	test "user name should not exceed 50 char" do 
		@user.name = "a" * 51
		assert_not @user.valid?
	end

	# User email testing suite

	test "user email should be present" do 
		@user.email = "     "
		assert_not @user.valid?
	end

	test "user email should not exceed 50 char maximum length" do 
		@user.email = "a" * 51
		assert_not @user.valid?
	end

	test "email validation should accept valid addresses" do
		valid_addresses = %w[janedoe@geemail.com JOHNdoe@geemail.COM jane_doe@gee.mail.com JOHN+JANE_DOE@geemail.co]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "#{valid_address.inspect} should be valid"
		end
	end

	test "email validation should reject invalid addresses" do
		invalid_addresses = %w[janedoe@geemail,com JOHNdoe_at_geemail.COM jane_doe@gee.mail. JOHN+JANE_DOE@gee_mail.co JOHN+JANE_DOE@gee+mail.co]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, "#{invalid_address.inspect} should NOT be valid"
		end
	end

	test "email validation should reject duplicate addresses" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	test "email addresses should be saved as lowercase" do
		mixed_case_email = "JaNeDoE@GeeMail.com"
		@user.email = mixed_case_email
		@user.save
		assert_equal mixed_case_email.downcase, @user.reload.email
	end

	# User username testing suite

	test "user username should be present" do
		@user.username = "     "
		assert_not @user.valid?		
	end

	test "user username should not exceed 25 char" do
		@user.username = "a" * 26
		assert_not @user.valid?
	end

	test "username should accept valid usernames" do
		valid_usernames = %w[janedoe JOHNdoe jane_doe john.doe JOHN.JANE_DOE123]
		valid_usernames.each do |valid_username|
			@user.username = valid_username
			assert @user.valid?, "#{valid_username.inspect} should be valid"
		end
	end

	test "username should reject invalid usernames" do
		invalid_usernames = %w[janedoe@ JOHNdoe$ jane_doe@gee.mail! JOHN+JANE_DOE@gee_mail.co @#$%^&*()]
		invalid_usernames.each do |invalid_username|
			@user.username = invalid_username
			assert_not @user.valid?, "#{invalid_username.inspect} should NOT be valid"
		end
	end

	test "username validation should reject duplicate usernames" do
		duplicate_user = @user.dup
		duplicate_user.username = @user.username.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	test "username validation should reject email addresses as username" do
		other_user = @user.dup
		other_user.email = "john_doe@gmail.com"
		other_user.username = @user.email.downcase
		@user.save
		assert_not other_user.valid?
	end

	test "usernames should be saved as lowercase" do
		mixed_case_username = "JaNe_DoE"
		@user.username = mixed_case_username
		@user.save
		assert_equal mixed_case_username.downcase, @user.reload.username
	end

	# User password testing suite

	test "password should be present" do
		@user.password = @user.password_confirmation = "     "
		assert_not @user.valid?
	end

	test "password should meet 8 char minimum length" do
		@user.password = @user.password_confirmation = "a" * 6
		assert_not @user.valid?
	end

	# User login/logout testing suite

	test "authenticated? should return false for a user with nil digest" do
		assert_not @user.authenticated?(:remember, '')
	end

	# User chirps

	test "associated chirps should be destroyed" do
		@user.save
		@user.chirps.create!(content: "Lorem ipsum")
		assert_difference 'Chirp.count', -1 do
			@user.destroy
		end
	end

	# Follow and Unfollow

	test "user should follow and unfollow another user" do
		yen = users(:yen)
		triss = users(:triss)
		assert_not yen.following?(triss)
		yen.follow(triss)
		assert yen.following?(triss)
		assert triss.followers.include?(yen)
		yen.unfollow(triss)
		assert_not yen.following?(triss)
	end

	test "feed should have the right posts" do 
		ciri = users(:cirilla)
		roach = users(:roach)
		yen = users(:yen)
		# Posts from followed user
		yen.chirps.each do |chirp_following|
			assert ciri.feed.include?(chirp_following)
		end
		# Posts from self
		ciri.chirps.each do |post_self|
			assert ciri.feed.include?(post_self)
		end
		# Post from unfollowed user
		roach.chirps.each do |post_unfollowed|
			assert_not yen.feed.include?(post_unfollowed)
		end
	end
end
