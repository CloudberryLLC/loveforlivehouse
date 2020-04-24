class AddPublishedToPerformerProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :performer_profiles, :published, :boolean
  end
end
