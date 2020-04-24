class PaymentExpiredJob < ApplicationJob
  queue_as :default

  retry_on ActiveRecord::StatementInvalid

  def perform(offer)
    @offer = Offer.find(offer.id)
    unless @offer.offer_status >= 13
      @offer.offer_status = 12
      if @offer.save
        OfferMailer.with(offer: offer).offer_expired_to_client.deliver_later
        OfferMailer.with(offer: offer).offer_expired_to_contractor.deliver_later
      end
    end
  end

end
