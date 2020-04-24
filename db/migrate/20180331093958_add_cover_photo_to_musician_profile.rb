class AddCoverPhotoToMusicianProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :musician_profiles, :cover_photo, :string
  end
end
