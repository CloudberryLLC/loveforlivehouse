class ApplicationMailer < ActionMailer::Base

  add_template_helper(ApplicationHelper)

  before_action {@admin_email = Rails.application.credentials.ADMIN_EMAIL}

  default from: 'loveforlivehouse@gmail.com'

  layout 'mailer'
  
end
