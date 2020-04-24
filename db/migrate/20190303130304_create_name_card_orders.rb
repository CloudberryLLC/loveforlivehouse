class CreateNameCardOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :name_card_orders do |t|
      t.references :name_card, foreign_key: true
      t.integer :amount
      t.date :delivery_date
      t.integer :price
      t.integer :payment_option
      t.date :payment_limit
      t.boolean :paid
      t.string :zipcode
      t.string :pref
      t.string :city
      t.string :street
      t.string :bldg
      t.string :reciever_name
      t.boolean :ordered

      t.timestamps
    end
  end
end
