# Preview all emails at http://localhost:3000/rails/mailers/review_mailer
class ReviewMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/review_mailer/to_admin
  def to_admin
    ReviewMailer.to_admin
  end

  # Preview this email at http://localhost:3000/rails/mailers/review_mailer/to_performer
  def to_performer
    ReviewMailer.to_performer
  end

  # Preview this email at http://localhost:3000/rails/mailers/review_mailer/to_client
  def to_client
    ReviewMailer.to_client
  end

end
