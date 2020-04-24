class AddUserIdToMusicianProfiles < ActiveRecord::Migration[5.1]
  def change
    add_reference :musician_profiles, :user, foreign_key: true
  end
end
