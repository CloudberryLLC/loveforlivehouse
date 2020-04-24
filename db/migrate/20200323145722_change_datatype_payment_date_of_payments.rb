class ChangeDatatypePaymentDateOfPayments < ActiveRecord::Migration[5.2]
  def change
    change_column :payments, :payment_date, :datetime
  end
end
