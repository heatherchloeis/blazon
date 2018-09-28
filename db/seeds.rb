User.create!(name: "Vesemir of Kaer Mohren",
						 email: "vesemir@kaermohren.com",
						 username: "vesemir",
						 password: "backinmyday",
						 password_confirmation: "backinmyday",
						 admin: true,
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name: "Cirilla of Cintra",
					   username: "cirilla",
					   email: "ciri@cintra.com",
					   password: "password",
					   password_confirmation: "password",
						 admin: true,
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name: "Geralt of Rivia",
  					 username: "geralt",
  					 email: "daddygeralt@rivia.com",
					   password: "password",
					   password_confirmation: "password",
						 admin: true,
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name: "Roach",
  					 username: "roach",
  					 email: "roach_the_horse@rivia.com",
					   password: "password",
					   password_confirmation: "password",
						 admin: true,
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name: "Triss Merigold",
  					 username: "triss",
  					 email: "triss_merigold@maribor.com",
					   password: "password",
					   password_confirmation: "password",
						 admin: true,
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name: "Yennifer of Vengerberg",
					   username: "yen",
					   email: "yennifer@vengerberg.com",
					   password: "password",
					   password_confirmation: "password",
						 admin: true,
						 activated: true,
						 activated_at: Time.zone.now)

99.times do |n|
	name = Faker::Name.name
	email = Faker::Internet.email
	username = Faker::Internet.username
	password = "password"
	User.create!(name: name,
							 email: email,
							 username: username,
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

users = User.all 
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }