class NameCardOrder < ApplicationRecord
  belongs_to :name_card, optional: true

  validates :amount, :payment_option, presence: true, on: :update
  validate :check_delivery_date, on: :update

  def check_delivery_date
    errors.add(:delivery_date, "は、本日より7日後以降の日付を入力してください。") unless
    self.delivery_date >= Date.today + 7.day
  end
end
