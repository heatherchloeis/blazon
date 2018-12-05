module UsersHelper
	# Returns the Gravatar for the given user.

	def count_notifications
		notifications = current_user.notifications.where.not(sender_id: current_user.id, read: true)
		return notifications.size
	end
end