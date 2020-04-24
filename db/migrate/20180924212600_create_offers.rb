class CreateOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :offers do |t|
      t.integer :user_id
      t.integer :client
      t.integer :contractor
      t.integer :offered_performer
      t.string :offer_status
      t.integer :last_update_from
      t.datetime :meeting_time
      t.boolean :meeting_time_confirmed
      t.datetime :release_time
      t.boolean :release_time_confirmed
      t.integer :playing_time
      t.boolean :playing_time_confirmed
      t.string :place
      t.text :dresscode
      t.text :contract
      t.text :request_from_client
      t.timestamps
    end
  end
end
