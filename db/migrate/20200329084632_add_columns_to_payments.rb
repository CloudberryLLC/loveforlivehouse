class AddColumnsToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :transport, :integer
    add_column :payments, :accommodation, :integer
    add_column :payments, :carriage, :integer
    add_column :payments, :equipment, :integer
    add_column :payments, :other_expenses, :integer
    add_column :payments, :charged_at, :date
    add_column :payments, :detail, :text
  end
end
