class Contact < ApplicationRecord
  default_scope -> { order(created_at: :asc) }

	belongs_to :user, optional: true
	belongs_to :offer, optional: true
	has_many :chat_messages, dependent: :destroy

	accepts_nested_attributes_for :chat_messages

end
