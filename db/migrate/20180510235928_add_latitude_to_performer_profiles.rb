class AddLatitudeToPerformerProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :performer_profiles, :latitude, :float
    add_column :performer_profiles, :longitude, :float
  end
end
