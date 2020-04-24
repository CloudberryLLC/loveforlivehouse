# Preview all emails at http://localhost:3000/rails/mailers/name_card_order_mailer
class NameCardOrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/name_card_order_mailer/order_confirmed
  def order_confirmed
    NameCardOrderMailer.order_confirmed
  end

  # Preview this email at http://localhost:3000/rails/mailers/name_card_order_mailer/coming_order
  def coming_order
    NameCardOrderMailer.coming_order
  end

end
