class InquiryMailer < ApplicationMailer
  add_template_helper(InquiriesHelper)
  before_action { @inquiry = params[:inquiry] }

  def inquiry_sent_successfly
    mail(to: @inquiry.email, subject: '[love_for_live_house] お問い合わせを受け付けました。')
  end

  def new_inquiry
    mail(to: @admin_email, subject: '【要対応】ユーザーからの問い合わせ')
  end

end
