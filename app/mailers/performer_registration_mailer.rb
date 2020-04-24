class PerformerRegistrationMailer < ApplicationMailer

  before_action { @performer = params[:performer_profile] }
  before_action { @user = User.find_by(id: @performer.user_id) }

  def admin
    mail(to: @admin_email, subject: 'パフォーマー登録申請の審査をお願いします。')
  end

  def user
    mail(to: @user.email, subject: 'パフォーマー登録申請を受け付けました。')
  end

  def admin_approved
    mail(to: @admin_email, subject: 'パフォーマー登録申請を承認しました。')
  end

  def user_approved
    mail(to: @user.email, subject: 'パフォーマー登録申請が承認されました。')
  end

end
