class CreateInquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :inquiries do |t|
      t.string :name
      t.string :email
      t.integer :type
      t.text :content
      t.boolean :closed

      t.timestamps
    end
  end
end
