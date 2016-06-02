# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_new_user
    UserMailer.welcome_new_user(User.last)
  end
end
