class Offer < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :user, optional: :true
  has_one :contact, dependent: :destroy
  has_one :estimation, dependent: :destroy
  has_one :arrangement, dependent: :destroy
  has_one :payment, dependent: :destroy
  has_one :review, dependent: :destroy
  has_one :cancelled_offer, dependent: :destroy

  accepts_nested_attributes_for :contact, :estimation, :arrangement, :payment, :review, :cancelled_offer

  validates :meeting_time, :release_time, :place, :playing_time, :description, presence: true, on: :update
  validate :start_end_check, on: :update
  validate :offer_start_date_check, on: :update

  def start_end_check
    errors.add(:release_time, "は入り時間より前に設定できません。") unless
    self.meeting_time < self.release_time
  end

  def offer_start_date_check
    errors.add(:meeting_time, "は銀行3営業日目から先の日付で設定してください。それ以前の日程ではオファーできません。") unless
    Time.current.beginning_of_day < 3.business_days.before(self.meeting_time.end_of_day)
  end

end
