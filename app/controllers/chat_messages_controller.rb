class ChatMessagesController < ApplicationController

	before_action :authenticate_user!
  before_action :certified_user_only

  def index
    @chat_messages = ChatMessage.all
  end

private

	def message_params(params)
		params.require(:chat_messages).permit(:contact_id, :from, :to, :body)
	end

end
