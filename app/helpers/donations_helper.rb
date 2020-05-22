module DonationsHelper

	def donation_token(donation)
		return Digest::SHA256.hexdigest(donation.id.to_s).to_s
	end

	def show_payment_method(payment_method)
		case payment_method
		when 1
			return "クレジットカード・デビットカード"
		when 2
			return "銀行振込"
		end
	end

end
