class AddSupporterIdToDonation < ActiveRecord::Migration[5.2]
  def change
    add_column :donations, :supporter_id, :integer
  end
end
