class CancelledOffer < ApplicationRecord
  belongs_to :offer, optional: true

#  validates :cancelled_by, presence: true
#  validates :cause, presence: true
#  validates :payback_rate, presence: true, on: :update

end
