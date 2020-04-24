class ChatMessageMailer < ApplicationMailer
  add_template_helper(OffersHelper)
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
    @offer = Offer.find(params[:offer_id])
    @subject = mail_subject(@sender, @offer)
  end

  def mail_subject(sender, offer)
    case sender.id
    when offer.client
      return "[love_for_live_house] クライアントからコンタクトがありました。"
    when offer.contractor
      return "[love_for_live_house] パフォーマーからコンタクトがありました。"
    else
      return "先方からコンタクトがありました。"
    end
  end

end
