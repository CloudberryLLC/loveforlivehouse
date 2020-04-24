class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :offer, foreign_key: true
      t.integer :reviewee
      t.integer :reviewer
      t.float :total_review
      t.float :quality
      t.float :confortability
      t.float :manners
      t.float :cost_performance
      t.float :fast_response
      t.text :comment
      t.timestamps
    end
  end
end
