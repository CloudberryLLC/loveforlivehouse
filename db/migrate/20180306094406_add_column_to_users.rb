class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :user_type, :integer
    add_column :users, :rule_confirmation, :boolean
  end
end
