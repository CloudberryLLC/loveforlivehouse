class AddUserIdToBanks < ActiveRecord::Migration[5.1]
  def change
    add_reference :banks, :user, foreign_key: true
  end
end
