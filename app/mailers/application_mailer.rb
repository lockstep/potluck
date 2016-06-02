class ApplicationMailer < ActionMailer::Base
  default from: "hello@potluck.com"
  layout 'mailer'
end
