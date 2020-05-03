class CreateDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :donations do |t|
      t.string :name
      t.integer :amount
      t.string :email
      t.string :phone
      t.string :zipcode
      t.string :pref
      t.string :city
      t.string :street
      t.string :bldg
      t.text :message
      t.text :bank_address
      t.boolean :confirmation

      t.timestamps
    end
  end
end
