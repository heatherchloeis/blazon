json.users do
	json.array!(@users) do |user|
		json.user "<b>#{user.name}</b> @#{user.username}"
		json.url user_path(user)
	end
end