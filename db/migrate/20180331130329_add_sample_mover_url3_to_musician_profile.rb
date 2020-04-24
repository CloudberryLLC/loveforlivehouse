class AddSampleMoverUrl3ToMusicianProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :musician_profiles, :sample_movie_url3, :text
  end
end
