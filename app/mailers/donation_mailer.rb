class DonationMailer < ApplicationMailer
  include DonationsHelper
  before_action { @donation = params[:donation] }
  before_action { @hash = params[:hash] }
  before_action { @livehouse = Livehouse.find(@donation.livehouse_id) }
  before_action { @user = User.find_by(id: @livehouse.user_id) }

  def bank_transfer_info
    mail(to: @donation.email, subject: '【LOVE for Live House】ライブハウスの口座情報をお送りします。')
  end

  def bank_transfer_completed
    mail(to: @donation.email, subject: '【LOVE for Live House】銀行振込完了がライブハウスに通知されました')
  end

  def bank_transferred_to_livehouse
    mail(to: @livehouse.shop_email, subject: '【LOVE for Live House】支援者から銀行振込完了が通知されました')
  end

end
