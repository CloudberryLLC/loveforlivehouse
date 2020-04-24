class ApplicationMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)

  before_action {@admin_url = ENV["ADMIN_URL"]}
  before_action {@admin_email = Rails.application.credentials.ADMIN_EMAIL}

  default from: 'noreply@love_for_live_house.jp'

  layout 'mailer'
end
