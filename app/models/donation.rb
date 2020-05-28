class Donation < ApplicationRecord
	validates :nickname, :amount, :message, :name, :email, :zipcode, :pref, :city, :street, :payment_method, presence: true
	validates :amount, numericality: { only_integer: true, message: "は、半角数字で入力してください" }
	validates :amount, numericality: { greater_than_or_equal_to: Constants::MINIMUM_AMOUNT, message: "は、#{Constants::MINIMUM_AMOUNT}円以上でお願い致します" }
end
