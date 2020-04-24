module ChatMessagesHelper

  def get_sender_photo(from)
		@sender = Basic.find_by("user_id = ?", from)
		return photo(@sender.profile_photo)
	end

	def get_sender_name(from)
			@sender = Basic.find_by("user_id = ?", from)
			return @sender.lastname + @sender.firstname
	end

  def message_color(from)
    if current_user.id == from
      return "chat-sender-body right"
    else
      return "chat-reciever-body left"
    end
  end

end
