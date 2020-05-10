class RenamePerformerProfileToLivehouse < ActiveRecord::Migration[5.2]
  def change
    rename_table :performer_profiles, :livehouses
  end
end
