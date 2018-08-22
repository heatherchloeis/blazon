require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: "Jane Doe", 
										 email: "janedoe@geemail.com",
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
		assert_not @user.authenticated?('')
	end
end
