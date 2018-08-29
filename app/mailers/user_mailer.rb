class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Activate Your Account Now!"
  end

  def password_reset(user)
  	@user = user
  	mail to: user.email, subject: "Please Reset Your Password"
  end
end
