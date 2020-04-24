class CreateArrangements < ActiveRecord::Migration[5.1]
  def change
    create_table :arrangements do |t|
      t.references :offer, foreign_key: true
      t.text :client_items
      t.text :performer_items

      t.timestamps
    end
  end
end
