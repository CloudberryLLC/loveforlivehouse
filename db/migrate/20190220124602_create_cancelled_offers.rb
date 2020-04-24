class CreateCancelledOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :cancelled_offers do |t|
      t.references :offer, foreign_key: true
      t.integer :cancelled_by
      t.text :cause
      t.integer :payback_rate

      t.timestamps
    end
  end
end
