class AddPaybackToCancelledOffer < ActiveRecord::Migration[5.2]
  def change
    add_column :cancelled_offers, :paid_to_client, :boolean
    add_column :cancelled_offers, :pay_amount_to_client, :integer
    add_column :cancelled_offers, :paid_to_performer, :boolean
    add_column :cancelled_offers, :pay_amount_to_performer, :integer
  end
end
