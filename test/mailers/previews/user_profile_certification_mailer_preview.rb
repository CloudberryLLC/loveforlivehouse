# Preview all emails at http://localhost:3000/rails/mailers/user_profile_certification_mailer
class UserProfileCertificationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_profile_certification_mailer/send_admin
  def send_admin
    UserProfileCertificationMailer.send_admin
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_profile_certification_mailer/send_user
  def send_user
    UserProfileCertificationMailer.send_user
  end

end
