class OfferExpirationJob < ApplicationJob
  queue_as :default

  def perform(offer)
    @offer = Offer.find(offer.id)
    case @offer.offer_status
    when 1, 2, 4, 5 #承諾に至らない場合
      @offer.offer_status = 10 #不成立(期限切れ)
      if @offer.save
        OfferMailer.with(offer: @offer).contact_expired_to_supporter.deliver_later
        OfferMailer.with(offer: @offer).contact_expired_to_contractor.deliver_later
      end
    else
      #承諾に至った場合(7, 8, 9)はPaymentExpiredJobに以降、こちらでは何もしない
      #不成立(3, 6, 10, 11, 12)の場合も何もしない
      #オファー確定以降(13以降)も何もしない
      return
    end
  end

end
