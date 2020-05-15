class AddPaymentIntentIdToDonation < ActiveRecord::Migration[5.2]
  def change
    add_column :donations, :payment_intent_id, :string
  end
end
