class NameCardOrderMailer < ApplicationMailer

  add_template_helper(NameCardOrdersHelper)
  before_action { set_order_data }

  def order_confirmed
    mail(to: @user.email, subject: '[LOVE for Live House] 名刺のオーダーを完了しました。')
  end

  def coming_order
    @admin = Rails.application.credentials.ADMIN_EMAIL
    mail(to: @admin_email, subject: '[名刺オーダー] 対応をお願いいたします。')
  end

private

  def set_order_data
    @order = params[:name_card_order]
    @namecard = NameCard.find(@order.name_card_id)
    @livehouse = Livehouse.find(@namecard.livehouse_id)
    @user = User.find(@livehouse.user_id)
  end
end
