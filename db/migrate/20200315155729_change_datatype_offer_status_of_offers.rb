class ChangeDatatypeOfferStatusOfOffers < ActiveRecord::Migration[5.2]
  def change
    change_column :offers, :offer_status, 'integer USING CAST(offer_status AS integer)'
  end
end
