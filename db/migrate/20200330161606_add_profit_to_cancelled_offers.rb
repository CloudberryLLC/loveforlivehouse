class AddProfitToCancelledOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :cancelled_offers, :profit, :integer
  end
end
