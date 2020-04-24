class NameCard < ApplicationRecord
  belongs_to :performer_profile, optional: true
  has_many :name_card_orders, dependent: :destroy
end
