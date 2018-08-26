User.create!(name: "Vesemir of Kaer Mohren",
						 email: "vesemir@kaermohren.com",
						 password: "backinmyday",
						 password_confirmation: "backinmyday",
						 admin: true)

99.times do |n|
	name = Faker::Name.name
	email = Faker::Internet.email
	password = "password"
	User.create!(name: name,
							 email: email,
							 password: password,
							 password_confirmation: password)
end