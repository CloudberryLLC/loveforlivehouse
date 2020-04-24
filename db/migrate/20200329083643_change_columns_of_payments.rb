class ChangeColumnsOfPayments < ActiveRecord::Migration[5.2]
  def change
    rename_column :payments, :payment_date, :payment_due
    rename_column :payments, :payment_completion_date, :recieved_at
  end
end
