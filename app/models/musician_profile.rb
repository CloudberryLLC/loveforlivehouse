class MusicianProfile < ApplicationRecord

	belongs_to :user, optional: true

	mount_uploader :profile_photo, PhotoUploader
	mount_uploader :cover_photo, PhotoUploader

	validates :sample_movie_url1, 
		format: { with: /\A(|https\:\/\/www\.youtube\.com\/.+|https\:\/\/youtu\.be\/.+)\Z|\s/, 
		message: "には、あなたのYoutubeのURLを\"https\:\"から入力してください"}
	validates :sample_movie_url2, 
		format: { with: /\A(|https\:\/\/www\.youtube\.com\/.+|https\:\/\/youtu\.be\/.+)\Z|\s/, 
			message: "には、あなたのYoutubeのURLを\"https\:\"から入力してください"}
	validates :sample_movie_url3, 
		format: { with: /\A(|https\:\/\/www\.youtube\.com\/.+|https\:\/\/youtu\.be\/.+)\Z|\s/, 
			message: "には、あなたのYoutubeのURLを\"https\:\"から入力してください"}

end