class CreateChatMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :chat_messages do |t|
      t.references :contact, foreign_key: true
      t.integer :from
      t.integer :to
      t.text :body

      t.timestamps
    end
  end
end
