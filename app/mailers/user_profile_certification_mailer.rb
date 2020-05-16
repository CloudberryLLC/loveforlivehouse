class UserProfileCertificationMailer < ApplicationMailer

  before_action { @user = params[:user] }

  def send_admin
    @url  = 'http://localhost:3000/admin'
    mail(to: @admin_email, subject: 'ユーザー登録/変更申請が入りました。')
  end

  def send_user
    mail(to: @user.email, subject: 'ユーザー登録/変更申請を受け付けました。')
  end

  def admin_approved
    mail(to: @admin_email, subject: 'ユーザー登録/変更申請を承認しました。')
  end

  def user_approved
    mail(to: @user.email, subject: 'ユーザー登録/変更申請が承認されました。')
  end

  def stripe_connected
    mail(to: @admin_email, subject: 'ユーザーがStripeアカウントの連携を行いました')
  end

end
