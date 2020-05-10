module ProfilesHelper
#ユーザートークン
	def user_token(user)
		return Digest::SHA256.hexdigest(user.id.to_s + user.email.to_s).to_s
	end
end
