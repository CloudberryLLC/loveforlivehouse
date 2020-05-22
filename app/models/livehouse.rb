class Livehouse < ApplicationRecord

  belongs_to :user, optional: true

  has_one_attached :profile_photo
  has_one_attached :cover_photo

  validates :required_amount, on: :update, presence: true,
    numericality: { only_integer: true, allow_blank: true, message: "は、半角数字で入力してください" }
  validates :livehouse_name, on: :update, presence: true
  validates :profile_short, on: :update, presence: true
  validates :profile_long, on: :update, presence: true
  validates :zipcode, :pref, :city, :street, on: :update, presence: true
  validates :shop_email, :shop_phone, on: :update, presence: true
  validates :shop_url, on: :update, presence: true,
    format: { with: /\A#{URI::regexp(%w(http https))}\z/, message: "URLは\"https\:\"または\"http\:\"から入力してください"}
  validates :company, :owner, :manager, :purpose, :case_of_surrender, on: :update, presence: true
  validates :bank_name, on: :update, presence: true
  validates :bank_branch, on: :update, presence: true
  validates :bank_branch_code, on: :update,
    numericality: { only_integer: true, allow_blank: true, message: "は、半角数字で入力してください" }
  validates :bank_type, on: :update, presence: true
  validates :bank_number, on: :update, presence: true,
    numericality: { only_integer: true, allow_blank: true, message: "は、半角数字で入力してください" }
  validates :bank_owner, on: :update, presence: true
  validates :bank_owner_kana, on: :update, presence: true,
    format: { with: /\A[ァ-ンー－]*\Z/, allow_blank: true, message:"は、全角カタカナで入力してください" }
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
