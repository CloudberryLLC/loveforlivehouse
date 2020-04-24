class AddOfferIdToChatMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :chat_messages, :offer_id, :integer
  end
end
