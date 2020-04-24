class AddAreaToMusicianProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :musician_profiles, :area, :string
  end
end
