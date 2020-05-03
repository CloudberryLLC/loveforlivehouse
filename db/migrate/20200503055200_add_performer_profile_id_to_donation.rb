class AddPerformerProfileIdToDonation < ActiveRecord::Migration[5.2]
  def change
    add_column :donations, :livehouse_id, :integer
  end
end
