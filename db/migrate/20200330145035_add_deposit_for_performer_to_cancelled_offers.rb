class AddDepositForPerformerToCancelledOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :cancelled_offers, :deposit_for_performer, :integer
  end
end
