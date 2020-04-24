class CreateNameCards < ActiveRecord::Migration[5.2]
  def change
    create_table :name_cards do |t|
      t.references :performer_profile, foreign_key: true
      t.string :your_part
      t.string :your_name
      t.string :your_name_kana
      t.string :your_group

      t.timestamps
    end
  end
end
