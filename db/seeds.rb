# Create users

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

# Create chirps

users = User.order(:created_at).take(6)

50.times do
	content = Faker::Lorem.sentence(5)
	users.each { |user| user.chirps.create!(content: content) }
end

# Create following/followers

users = User.all 

vesemir = users.first
ciri = users[1]
geralt = users[2]
roach = users[3]
triss = users[4]
yen = users[5]

following = users[6..50]
followers = users[6..40]

following.each { |followed| vesemir.follow(followed) }
following.each { |followed| ciri.follow(followed) }
following.each { |followed| geralt.follow(followed) }
following.each { |followed| roach.follow(followed) }
following.each { |followed| triss.follow(followed) }
following.each { |followed| yen.follow(followed) }

followers.each { |follower| follower.follow(vesemir) }
followers.each { |follower| follower.follow(ciri) }
followers.each { |follower| follower.follow(geralt) }
followers.each { |follower| follower.follow(roach) }
followers.each { |follower| follower.follow(triss) }
followers.each { |follower| follower.follow(yen) }