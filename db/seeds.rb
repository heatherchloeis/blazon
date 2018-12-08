# Create users
require 'faker'

User.create!(name: "Effy :•* ☆",
						 email: "fawnnne@gmail.com",
						 username: "fawnnne",
						 password: "new12334",
						 password_confirmation: "new12334",
						 admin: true,
						 activated: true,
						 bio: "beep boop",
						 birthdate: "June 10, 1991",
						 location: "California, USA",
						 activated_at: Time.zone.now)

User.create!(name: "Burnt",
						 email: "DJCarrillo89@gmail.com",
						 username: "burnt89",
						 password: "new12334",
						 password_confirmation: "new12334",
						 admin: true,
						 activated: true,
						 bio: "beep boop",
						 birthdate: "June 09, 1989",
						 location: "California, USA",
						 activated_at: Time.zone.now)