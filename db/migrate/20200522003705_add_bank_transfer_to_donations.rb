class AddBankTransferToDonations < ActiveRecord::Migration[5.2]
  def change
    rename_column :donations, :bank_address, :bank_account_of_supporter
    add_column :donations, :payment_method, :integer
    add_column :livehouses, :bank_name, :string
    add_column :livehouses, :bank_branch, :string
    add_column :livehouses, :bank_branch_code, :string
    add_column :livehouses, :bank_type, :string
    add_column :livehouses, :bank_number, :string
    add_column :livehouses, :bank_owner, :string
    add_column :livehouses, :bank_owner_kana, :string
  end
end
