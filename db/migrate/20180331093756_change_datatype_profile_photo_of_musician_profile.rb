class ChangeDatatypeProfilePhotoOfMusicianProfile < ActiveRecord::Migration[5.1]
  def change
  	change_column :musician_profiles, :profile_photo, :string
  end
end
