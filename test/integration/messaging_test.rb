require 'test_helper'

class MessagingTest < ActionDispatch::IntegrationTest
	def setup
		@sender = users(:cirilla)
		@recipient = users(:triss)
		log_in_as(@sender)
		@users = users
	end

	test "messaging page" do 
		get conversations_path(@sender)
		@users.each do |user|
			user != @sender
			assert_select 'h5', text: "Direct Messages"
			assert_select "a[href=?]", user_path(user)
			assert_select "form.button_to", action: conversations_path(sender_id: @sender.id, recipient_id: user.id)
			assert_select "input[type=submit]"
		end
	end

	test "should create new message" do
		get conversations_path(@sender)
		assert_difference 'Conversation.count', 1 do
			post conversations_path(sender_id: @sender.id, recipient_id: @recipient.id)
			assert :success
		end
		follow_redirect!
		assert_select 'textarea'
		assert_select 'input[type=submit]'
		assert_difference 'Message.count', 1 do
			post conversation_messages_path, params: { message: { body: "This is a test", user_id: @sender.id } }
			assert :success
		end
	end
end