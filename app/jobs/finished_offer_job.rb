class FinishedOfferJob < ApplicationJob
  queue_as :default

  retry_on ActiveRecord::StatementInvalid

  def perform(offer)
    @offer = Offer.find(offer.id)
    if @offer.offer_status == 13 #オファー確定
      @offer.offer_status = 17 #オファー完了
      if @offer.save
        OfferMailer.with(offer: @offer).offer_complited_to_client.deliver_later
      end
    end
  end

end
