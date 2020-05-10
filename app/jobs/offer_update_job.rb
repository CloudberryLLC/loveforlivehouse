class OfferUpdateJob < ApplicationJob
  queue_as :default

  def perform(offer)
    case offer.offer_status
    when 1
      OfferMailer.with(offer: offer).new_offer.deliver_later
      redirect_to offer_path(offer), notice: "ライブハウスに新規オファーを出しました。"
    when 3 #ライブハウスよりオファーが断られた場合
      OfferMailer.with(offer: offer).livehouse_unaccepted.deliver_later
      redirect_to offer_path(offer), notice: "このオファーを見送りました。"
    when 4 #ライブハウスが依頼を受け、見積りを出した場合
      OfferMailer.with(offer: offer).estimation_to_client.deliver_later
      redirect_to offer_path(offer), notice: "クライアントに見積りを送りました。"
    when 5 #クライアントより再見積り依頼が来た場合
      OfferMailer.with(offer: offer).re_estimate_order.deliver_later
      redirect_to offer_path(offer), notice: "ライブハウスに再見積りを依頼しました。"
    when 6 #クライアントよりオファーが断られた場合
      OfferMailer.with(offer: offer).client_unaccepted.deliver_later
      redirect_to offer_path(offer), notice: "このオファーを見送りました。"
    when 7 #クライアントが見積りを承認し、オファーが成立した場合
      OfferMailer.with(offer: offer).estimation_accepted.deliver_later
      PaymentExpiredJob.set(wait_until: payment_due(offer.updated_at, offer.release_time)).perform_later(offer)
      redirect_to new_payment_path(offer, id: offer.id, estimation: offer.estimation), notice: "このオファーを承認しました。"
    when 8 #クライアントが見積りを承認し、オファーが成立した場合
      create_charge(offer.id, offer.payment.total)
      redirect_to offer_path(offer), notice: "このオファーの支払いを行いました。"
    when 13 #クライアントが支払を完了した場合
      FinishedOfferJob.set(wait_until: offer.release_time).perform_later(offer)
      redirect_to new_payment_path(offer, id: offer.id), notice: "お支払いが完了しました。"
    else
      redirect_to offer_path(offer), notice: "オファーの内容を変更しました。"
    end
  end
end
