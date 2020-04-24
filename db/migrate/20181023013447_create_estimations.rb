class CreateEstimations < ActiveRecord::Migration[5.1]
  def change
    create_table :estimations do |t|
      t.references :offer
      t.integer :guarantee
      t.integer :staff
      t.integer :withholding_taxes
      t.integer :system_fee
      t.integer :transport
      t.integer :accommodation
      t.integer :carriage
      t.integer :equipment
      t.integer :other_expenses
      t.text :detail

      t.timestamps
    end
  end
end
