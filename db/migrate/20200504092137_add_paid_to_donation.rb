class AddPaidToDonation < ActiveRecord::Migration[5.2]
  def change
    add_column :donations, :paid, :boolean
  end
end
