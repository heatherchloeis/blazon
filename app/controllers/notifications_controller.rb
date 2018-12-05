class NotificationsController < ApplicationController
  def link_through
  	@notification = Notification.find_by(id: params[:notification_id])
  	@notification.update read: true
  	if !@notification.post.nil?
  		redirect_back fallback_location: root_path
  	elsif !@notification.conversation.nil?
  		redirect_to conversation_messages_path @notification.conversation
  	end
  end
end