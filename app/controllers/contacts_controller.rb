class ContactsController < ApplicationController

	before_action :authenticate_user!
  before_action :certified_user_only

  def index
  	@contacts = Contact.where('user1 = ? or user2 = ?', current_user.id, current_user.id)
  end

  def new
  end

  def show
		set_contact(params[:id])
  end

	def post
		@message = ChatMessage.new(message_params)
		if @message.save
			ContactChannel.broadcast_to(@message.contact_id, chat_message: render_new_message(@message))
			ChatMessageMailer.with(sender: @message.from, reciever: @message.to, body: @message.body, offer_id: @message.offer_id).send_reciever_message.deliver_later
			head :ok
		end
	end


private

	def set_contact(contact_id)
  	@contact = Contact.find(params[:id])
  	@user1 = User.find(@contact.user1)
  	@user2 = User.find(@contact.user2)
		@performer = PerformerProfile.find(@contact.performer)
		@from = current_user
		if @from.id == @user1.id
			@to = @user2
		elsif @from.id == @user2.id
			@to = @user1
		else
			render "index"
		end
		@messages = ChatMessage.where(contact_id: @contact.id)
		@message = ChatMessage.new
  end

	def message_params
		params.require(:chat_message).permit(:contact_id, :offer_id, :from, :to, :body)
	end

	def render_new_message(message)
		renderer = ApplicationController.renderer_with_signed_in_user(message)
		renderer.render(partial: 'chat_messages/new_message', locals: {chat_message: message})
	end


end
