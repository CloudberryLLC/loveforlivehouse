class Review < ApplicationRecord
  belongs_to :offer, optional: :true

  validates :total_review, presence: true
  validates :quality, presence: true
  validates :confortability, presence: true
  validates :cost_performance, presence: true
  validates :manners, presence: true
  validates :fast_response, presence: true
end
