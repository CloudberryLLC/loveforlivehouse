class AddUserIdToBasics < ActiveRecord::Migration[5.1]
  def change
    add_reference :basics, :user, foreign_key: true
  end
end
