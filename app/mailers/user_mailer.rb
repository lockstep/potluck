class UserMailer < ApplicationMailer
  default from: 'hello@potluck.com'

  def welcome_new_user(user,password=nil)
    @user = user
    @url  = new_user_session_url
    @password = password unless password
    mail(to: @user.email, subject: 'Welcome to Potluck')
  end
end
