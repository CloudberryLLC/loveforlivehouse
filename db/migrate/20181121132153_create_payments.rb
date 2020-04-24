class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.references :offer, foreign_key: true
      t.integer :total
      t.integer :guarantee
      t.integer :pre_paid_expenses
      t.integer :management_fee
      t.integer :staff
      t.integer :consumption_tax
      t.integer :withholding_tax
      t.string :card
      t.integer :transfer_fee
      t.integer :system_fee
      t.integer :payment_options
      t.date :payment_date
      t.boolean :paid
      t.datetime :payment_completion_date

      t.timestamps
    end
  end
end
