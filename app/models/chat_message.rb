class ChatMessage < ApplicationRecord
  belongs_to :contact, optional: true

  #無記入投稿とエンター長押しの連続投稿の2つが同時に防げる
  validates :body, presence: true
  # after_create_commit {ChatMessageBroadcastJob.perform_later self}

end
