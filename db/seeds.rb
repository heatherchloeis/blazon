User.create!(name: "Vesemir of Kaer Mohren",
						 email: "vesemir@kaermohren.com",
						 password: "backinmyday",
						 password_confirmation: "backinmyday",
						 admin: true,
						 activated: true,
						 activated_at: Time.zone.now)

99.times do |n|
	name = Faker::Name.name
	email = Faker::Internet.email
	password = "password"
	User.create!(name: name,
							 email: email,
							 password: password,
							 password_confirmation: password,
							 activated: true,
							 activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)

50.times do
	content = Faker::Lorem.sentence(5)
	users.each { |user| user.chirps.create!(content: content) }
end