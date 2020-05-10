class ChatMessageMailer < ApplicationMailer
  before_action { set_mail_content }

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.chat_message_mailer.send_reciever_message.subject
  #
  def send_reciever_message
    mail(to: @reciever.email, subject: @subject)
  end

private

  def set_mail_content
    @sender = User.find(params[:sender])
    @reciever = User.find(params[:reciever])
    @body = params[:body]
    @subject = mail_subject(@sender)
  end

  def mail_subject(sender, offer)
    case sender.id
    when offer.client
      return "[LOVE for Live House] クライアントからコンタクトがありました。"
    when offer.contractor
      return "[LOVE for Live House] ライブハウスからコンタクトがありました。"
    else
      return "先方からコンタクトがありました。"
    end
  end

end
