class CreateBasics < ActiveRecord::Migration[5.1]
  def change
    create_table :basics do |t|
      t.string :lastname
      t.string :firstname
      t.string :lastname_kana
      t.string :firstname_kana
      t.string :company
      t.string :department
      t.string :phone
      t.string :zipcode
      t.string :pref
      t.string :city
      t.string :street
      t.string :bldg
      t.binary :id_front
      t.binary :id_back
      t.binary :company_certification

      t.timestamps
    end
  end
end
