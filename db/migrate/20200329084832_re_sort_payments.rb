class ReSortPayments < ActiveRecord::Migration[5.2]
  def change
    change_table :payments do |t|
      t.change :guarantee, :integer, after: :total
      t.change :staff, :integer, after: :guarantee
      t.change :management_fee, :integer, after: :staff
      t.change :withholding_tax, :integer, after: :management_fee
      t.change :system_fee, :integer, after: :withholding_tax
      t.change :transport, :integer, after: :system_fee
      t.change :accommodation, :integer, after: :transport
      t.change :carriage, :integer, after: :accommodation
      t.change :equipment, :integer, after: :carriage
      t.change :other_expenses, :integer, after: :equipment
      t.change :consumption_tax, :integer, after: :other_expenses
      t.change :payment_options, :integer, after: :consumption_tax
      t.change :payment_due, :datetime, after: :payment_options
      t.change :paid, :boolean, after: :payment_due
      t.change :charged_at, :datetime, after: :paid
      t.change :recieved_at, :datetime, after: :charged_at
      t.change :created_at, :datetime, after: :recieved_at
      t.change :updated_at, :datetime, after: :created_at
    end
  end
end
