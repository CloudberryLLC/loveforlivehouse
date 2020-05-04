class AddRecieverToDonation < ActiveRecord::Migration[5.2]
  def change
    add_column :donations, :reciever, :integer
  end
end
