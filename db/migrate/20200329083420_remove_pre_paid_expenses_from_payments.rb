class RemovePrePaidExpensesFromPayments < ActiveRecord::Migration[5.2]
  def up
    remove_column :payments, :pre_paid_expenses
  end
  def down
    add_column :payments, :pre_paid_expenses, :integer
  end
end
