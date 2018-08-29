class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Activate Your Account Now!"
  end

  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
