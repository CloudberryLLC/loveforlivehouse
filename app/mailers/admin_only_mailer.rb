class AdminOnlyMailer < ApplicationMailer
  def failed_login_attempt
    @user = params[:user]
    mail(to: @admin_email, subject: '管理画面へのログインが試みられました。')
  end
end
