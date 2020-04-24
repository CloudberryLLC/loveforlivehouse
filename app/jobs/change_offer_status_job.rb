class ChangeOfferStatusJob < ApplicationJob
  queue_as :default

  def perform(offer)
    offer.offer_status = 9
    offer.save!
  end

end
