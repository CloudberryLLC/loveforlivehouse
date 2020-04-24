class PerformerProfile < ApplicationRecord

  belongs_to :user, optional: true
  has_one :name_card, dependent: :destroy

  accepts_nested_attributes_for :name_card

  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :instruments, :music_genres

  has_one_attached :profile_photo
  has_one_attached :cover_photo

	#mount_uploader :profile_photo, PhotoUploader
	#mount_uploader :cover_photo, PhotoUploader

	#refer to https://github.com/alexreisner/geocoder
	geocoded_by :area   # can also be an IP address
	after_validation :geocode         # auto-fetch coordinates

  validates :performer_name, :performer_rank, :number_of_member, on: :update, presence: true
  validates :number_of_member, :basic_guarantee, on: :update, numericality: { only_integer: true, allow_blank: true, message: "は、半角数字で入力してください" }

	validates :sample_movie_url1, on: :update,
		format: { with: /\A(|https\:\/\/www\.youtube\.com\/.+|https\:\/\/youtu\.be\/.+)\Z|\s/,
		message: "には、あなたのYoutubeのURLを\"https\:\"から入力してください"}
	validates :sample_movie_url2, on: :update,
		format: { with: /\A(|https\:\/\/www\.youtube\.com\/.+|https\:\/\/youtu\.be\/.+)\Z|\s/,
			message: "には、あなたのYoutubeのURLを\"https\:\"から入力してください"}
	validates :sample_movie_url3, on: :update,
		format: { with: /\A(|https\:\/\/www\.youtube\.com\/.+|https\:\/\/youtu\.be\/.+)\Z|\s/,
			message: "には、あなたのYoutubeのURLを\"https\:\"から入力してください"}
  validate :check_minimum_guarantee, on: :update


  private

  def check_minimum_guarantee
    if basic_guarantee.blank?
      errors.add(:basic_guarantee, "は空欄にできません")
    else
      case performer_rank
      when "1" #専業プロフェッショナルの場合
        minimum_guarantee = Constants::PROFESSIONAL_MINIMUM_GUARANTEE
      when "2" #プロ志望者及び兼業プロフェッショナルの場合
        minimum_guarantee = Constants::SEMI_PROFESSIONAL_MINIMUM_GUARANTEE
      when "3" #アマチュアの場合
        minimum_guarantee = Constants::AMATEUR_MINIMUM_GUARANTEE
      end
      errors.add(:basic_guarantee, "は、#{minimum_guarantee.to_s(:delimited)}円以上の金額を入力してください。") unless basic_guarantee >= minimum_guarantee
    end
  end

end
