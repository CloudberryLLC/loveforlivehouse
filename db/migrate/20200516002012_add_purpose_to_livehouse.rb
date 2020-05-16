class AddPurposeToLivehouse < ActiveRecord::Migration[5.2]
  def change
    add_column :livehouses, :purpose, :text
    add_column :livehouses, :case_of_surrender, :text
  end
end
