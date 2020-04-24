class ReviewMailer < ApplicationMailer

  add_template_helper(OffersHelper)

  before_action { @admin = Rails.application.credentials.ADMIN_EMAIL }
  before_action { @offer = params[:offer] }
  before_action { set_offer_data(@offer) }

  def to_admin
    mail(to: @admin, subject: '[MUSICIANBOOK] フィードバックが届きました。')
  end

  def to_contractor
    mail(to: @contractor.email, subject: '[MUSICIANBOOK] レビューが投稿されました。')
  end

  def to_client
    mail(to: @client.email, subject: '[MUSICIANBOOK] レビューを投稿しました。')
  end

private

  def set_offer_data(offer)
    @review = offer.review
    @client = User.find(offer.client)
    @contractor = User.find(offer.contractor)
    @performer = PerformerProfile.find(offer.offered_performer)
  end

end
