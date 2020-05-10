class RenamePerformerNameColumnOfLivehouse < ActiveRecord::Migration[5.2]
  def change
    rename_column :livehouses, :performer_name, :livehouse_name
    rename_column :livehouses, :basic_guarantee, :required_amount
    rename_column :livehouses, :conditions, :capacity

    remove_column :livehouses, :performer_rank
    remove_column :livehouses, :number_of_member
    remove_column :livehouses, :latitude
    remove_column :livehouses, :longitude
    remove_column :livehouses, :set_of_instruments
  end
end
