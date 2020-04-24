class OfferMailer < ApplicationMailer

  add_template_helper(OffersHelper)
  before_action { @offer = params[:offer] }
  before_action { set_offer_data(@offer) }

  def new_offer #1
    mail(to: @contractor.email, subject: '[love_for_live_house] クライアントよりオファーが届きました。')
  end

  def offer_changed #2
    mail(to: @contractor.email, subject: '[love_for_live_house] オファーの内容が変更されました。')
  end

  def performer_unaccepted #3
    mail(to: @client.email, subject: '[love_for_live_house] オファーが成立しませんでした。')
  end

  def estimation_to_client #4
    mail(to: @client.email, subject: '[love_for_live_house] パフォーマーより見積りが届きました。')
  end

  def re_estimate_order #5
    mail(to: @contractor.email, subject: '[love_for_live_house] クライアントから再見積り依頼がありました。')
  end

  def client_unaccepted #6
    mail(to: @contractor.email, subject: '[love_for_live_house] オファーが成立しませんでした。')
  end

  def estimation_accepted #7
      mail(to: @contractor.email, subject: '[love_for_live_house] クライアントが見積りを承認しました。')
  end

  def payment_request_to_client #7
    mail(to: @client.email, subject: '[love_for_live_house] オファー承諾後のお支払いについて')
  end

  def charge_created #9
    @admin = Rails.application.credentials.ADMIN_EMAIL
    mail(to: @admin, subject: 'オファー支払い状況の確認をお願いします。')
  end

  def contact_expired_to_client #10
    mail(to: @client.email, subject: '[love_for_live_house] オファーが期限切れのためキャンセルとなりました。')
  end

  def contact_expired_to_contractor #10
    mail(to: @contractor.email, subject: '[love_for_live_house] オファーが期限切れのためキャンセルとなりました。')
  end

  def offer_expired_to_client #12
    mail(to: @client.email, subject: '[love_for_live_house] オファーが支払期限切れのためキャンセルとなりました。')
  end

  def offer_expired_to_contractor #12
    mail(to: @contractor.email, subject: '[love_for_live_house] オファーが支払期限切れのためキャンセルとなりました。')
  end

  def offer_confirmed_to_client #13
    mail(to: @client.email, subject: '[love_for_live_house] オファー確定のお知らせ。')
  end

  def offer_confirmed_to_contractor #13
    mail(to: @contractor.email, subject: '[love_for_live_house] オファー確定のお知らせ。')
  end

  def offer_cancelled_to_client #14, 15, 16
    mail(to: @client.email, subject: '[love_for_live_house] オファーがキャンセルされました。')
  end

  def offer_cancelled_to_contractor #14, 15, 16
    mail(to: @contractor.email, subject: '[love_for_live_house] オファーがキャンセルされました。')
  end

  def offer_cancelled_to_admin #14, 15, 16
    @admin = Rails.application.credentials.ADMIN_EMAIL
    mail(to: @admin, subject: '[オファーキャンセル通知] 返金対応をお願いします。')
  end

  def offer_complited_to_client #17
    mail(to: @client.email, subject: '[love_for_live_house] レビューをお願い致します。')
  end

private

  def set_offer_data(offer)
    @client = User.find(offer.client)
    @contractor = User.find(offer.contractor)
    @performer = PerformerProfile.find(offer.offered_performer)
  end

end
