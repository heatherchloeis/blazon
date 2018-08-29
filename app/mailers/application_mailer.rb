class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@canary.com'
  layout 'mailer'
end
