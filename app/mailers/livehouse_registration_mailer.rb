class LivehouseRegistrationMailer < ApplicationMailer

  before_action { @livehouse = params[:livehouse] }
  before_action { @user = User.find_by(id: @livehouse.user_id) }

  def admin
    mail(to: @admin_email, subject: 'ライブハウス登録申請の審査をお願いします。')
  end

  def user
    mail(to: @user.email, subject: 'ライブハウス登録申請を受け付けました。')
  end

  def admin_approved
    mail(to: @admin_email, subject: 'ライブハウス登録申請を承認しました。')
  end

  def user_approved
    mail(to: @user.email, subject: 'ライブハウス登録申請が承認されました。')
  end

end
