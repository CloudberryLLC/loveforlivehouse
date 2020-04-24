# Preview all emails at http://localhost:3000/rails/mailers/chat_message_mailer
class ChatMessageMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/chat_message_mailer/send_reciever_message
  def send_reciever_message
    ChatMessageMailer.send_reciever_message
  end

end
