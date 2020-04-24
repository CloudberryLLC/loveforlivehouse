class CreateBanks < ActiveRecord::Migration[5.1]
  def change
    create_table :banks do |t|
      t.string :bank_name
      t.string :bank_branch
      t.string :bank_branch_code
      t.string :bank_type
      t.string :bank_number
      t.string :bank_owner
      t.string :bank_owner_kana

      t.timestamps
    end
  end
end
