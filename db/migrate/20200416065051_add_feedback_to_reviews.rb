class AddFeedbackToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :report, :text
    add_column :reviews, :feedback, :text
  end
end
