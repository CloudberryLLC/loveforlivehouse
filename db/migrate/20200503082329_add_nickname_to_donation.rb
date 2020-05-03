class AddNicknameToDonation < ActiveRecord::Migration[5.2]
  def change
    add_column :donations, :nickname, :string
  end
end
