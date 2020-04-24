# Preview all emails at http://localhost:3000/rails/mailers/offer_mailer
class OfferMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/offer_mailer/new_offer_notice
  def new_offer_notice
    OfferMailer.new_offer_notice
  end

end
