class Livehouse < ApplicationRecord

  belongs_to :user, optional: true

  has_one_attached :profile_photo
  has_one_attached :cover_photo

  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :instruments, :music_genres

  validates :required_amount, :livehouse_name, :profile_short, :profile_long, :zipcode, :pref, :city, :street, :shop_email, :shop_phone, :shop_url, :company, :owner, :manager, on: :update, presence: true
  validates :required_amount, on: :update, numericality: { only_integer: true, allow_blank: true, message: "は、半角数字で入力してください" }

	validates :shop_url, on: :update,
		format: { with: /\A#{URI::regexp(%w(http https))}\z/,
		message: "URLは\"https\:\"または\"http\:\"から入力してください"}
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
