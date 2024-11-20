class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url = new_user_session_url
    mail(to: @user.email, subject: "Welcome to our site!")
  end
end
