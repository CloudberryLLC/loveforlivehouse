class AddRecievedAmountToCancelledOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :cancelled_offers, :recieved_amount, :integer
  end
end
