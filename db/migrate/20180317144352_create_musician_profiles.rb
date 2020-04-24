class CreateMusicianProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :musician_profiles do |t|
      t.string :musician_name
      t.string :musician_class
      t.string :instrument1
      t.string :instrument2
      t.binary :profile_photo
      t.text :profile_short
      t.text :profile_long
      t.text :sample_movie_url1
      t.text :sample_movie_url2
      t.integer :basic_guarantee
      t.text :play_condition
      t.text :play_condition_detail

      t.timestamps
    end
  end
end
