class AddGetAmountToLivehouse < ActiveRecord::Migration[5.2]
  def change
    add_column :livehouses, :funded_whole_period, :integer, default: 0
    add_column :livehouses, :funded_this_month, :integer, default: 0
    add_column :livehouses, :donators_whole_period, :integer, default: 0
    add_column :livehouses, :donators_this_month, :integer, default: 0
  end
end
