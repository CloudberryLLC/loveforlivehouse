module DonationsHelper
	def donation_token(donation)
		return Digest::SHA256.hexdigest(donation.id.to_s).to_s
	end
end
