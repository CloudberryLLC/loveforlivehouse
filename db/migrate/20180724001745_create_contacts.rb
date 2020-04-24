class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.integer :performer
      t.integer :user1
      t.integer :user2

      t.timestamps
    end
  end
end
