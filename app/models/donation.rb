class Donation < ApplicationRecord
	validates :nickname, :amount, :message, :name, :email, presence: true
	validates :amount, numericality: { only_integer: true, message: "は、半角数字で入力してください" }
end
