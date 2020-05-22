class Donation < ApplicationRecord
	validates :nickname, :amount, :message, :name, :email, :zipcode, :pref, :city, :street, presence: true
	validates :amount, numericality: { only_integer: true, message: "は、半角数字で入力してください" }
	validates :amount, numericality: { greater_than_or_equal_to: 100, message: "は、100円以上でお願い致します" }
end
