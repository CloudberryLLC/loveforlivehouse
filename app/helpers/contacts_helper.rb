module ContactsHelper

	def get_reciever_name(user1, user2)
		#user1がcurrent_userの場合はuser2、そうでない場合はuser1を表示
		if user1 == current_user.id
			@reciever = Basic.find_by("user_id = ?", user2)
		else
			@reciever = Basic.find_by("user_id = ?", user1)
		end

		if @reciever.nil?
			return "プロフィール未作成のユーザー"
		else
			return @reciever.lastname + @reciever.firstname
		end
	end

	def get_reciever_photo(user1, user2)
		begin
			#user1がcurrent_userの場合はuser2、そうでない場合はuser1を表示
			if user1 == current_user.id
				reciever = Basic.find_by("user_id = ?", user2)
			else
				reciever = Basic.find_by("user_id = ?", user1)
			end
			return reciever.profile_photo
		rescue
			return 'nophoto.png'
		end
	end

	def get_livehouse_name(livehouse)
		begin
			@livehouse = Livehouse.find(livehouse)
			@livehouse.livehouse_name
		rescue
			return nil
		end
	end

end
