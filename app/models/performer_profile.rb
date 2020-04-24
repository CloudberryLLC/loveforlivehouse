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

  validates :basic_guarantee, :performer_name, :profile_short, :profile_long, on: :update, presence: true
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

  private

end
