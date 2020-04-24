class AddCertifiedToPerformerProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :performer_profiles, :certified, :boolean
  end
end
