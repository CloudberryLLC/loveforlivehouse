class CreatePerformerProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :performer_profiles do |t|
      t.references :user, foreign_key: true
      t.string :performer_name
      t.string :performer_rank
      t.string :genre
      t.string :area
      t.integer :number_of_member
      t.text :profile_short
      t.text :profile_long
      t.integer :basic_guarantee
      t.text :conditions
      t.text :conditions_detail
      t.text :sample_movie_url1
      t.text :sample_movie_url2
      t.text :sample_movie_url3
      t.string :profile_photo
      t.string :cover_photo

      t.timestamps
    end
  end
end
