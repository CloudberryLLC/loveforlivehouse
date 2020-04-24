class OffersController < ApplicationController

  before_action :authenticate_user!
  before_action :certified_user_only
  before_action :set_current_user
  before_action :set_offer, only:[:show, :edit, :update, :post, :cancel, :destroy]
  before_action :get_users, only:[:show, :edit, :update, :cancel]

  def index
  	@offers = Offer.where('client = ? or contractor = ?', current_user.id, current_user.id).page(params[:page]).per(10)
  end

  def new
    set_new_offer
    redirect_to offer_path(@offer)
  end

  def create
    #使用せず。
  end

  def show
    if (current_user.id == @offer.client || current_user.id == @offer.contractor)
      #オファー完了時にレビューのページへ誘導
      set_chat(@offer)
      if @offer.offer_status == 17
        redirect_to new_review_path(@offer, id: @offer.id)
      end
    else
      redirect_to root_path, notice:"URLに間違いがあります。"
    end
  end

  def edit
    set_chat(@offer)
  end

  def update
    before_update(@offer)
    if @offer.update(offer_params)
      after_updated(@offer)
    else
      render "edit"
    end
  end

  def destroy
    #管理者のみ操作可
    if current_user.admin == true
      @offer.destroy
      redirect_to root_path, notice: "オファーを削除しました。"
    end
  end

	def post
		@message = ChatMessage.new(message_params)
		if @message.save
			ContactChannel.broadcast_to(@message.contact_id, chat_message: render_new_message(@message))
			ChatMessageMailer.with(sender: @message.from, reciever: @message.to, body: @message.body, offer_id: @message.offer_id).send_reciever_message.deliver_later
			head :ok
		end
	end

  def cancel
    begin
    #通常のupdateアクションだとオファー日時のバリデーションに引っかかるので仕方なく先に@offerに値を代入
      before_cancel(@offer)
      if @offer.save(validate: false)
        after_updated(@offer)
      else
        head :bad_request
      end
    rescue
      head :bad_request
    end
  end

private

#ストロングパラメータ
  def user_params
    params.require(:user).permit(
      offers_attributes: [:offer_status, :client, :contractor, :offered_performer, :last_update_from, :meeting_time, :meeting_time_confirmed, :release_time, :release_time_confirmed, :playing_time, :playing_time_confirmed, :place, :dresscode, :contract, :request_from_client, :description, :equipments, :rehearsal, :carry_in, :parking, :dressing_room, :stage, :accommodation, :other_condition, :user_id, :stripeToken, :_destroy, :id]
      )
  end

  def offer_params
    params.require(:offer).permit(
      :offer_status, :client, :contractor, :offered_performer, :last_update_from, :meeting_time, :meeting_time_confirmed, :release_time, :release_time_confirmed, :playing_time, :playing_time_confirmed, :place, :dresscode, :contract, :request_from_client, :description, :equipments, :rehearsal, :carry_in, :parking, :dressing_room, :stage, :accommodation, :other_condition, :user_id, :stripeToken,
      estimation_attributes: [:guarantee, :staff, :withholding_tax, :system_fee, :consumption_tax, :transport, :accommodation, :carriage, :equipment, :other_expenses, :detail, :_destroy, :id],
      arrangement_attributes: [:client_items, :performer_items, :_destroy, :id],
      payment_attributes: [:total, :guarantee, :staff, :management_fee, :staff, :system_fee, :withholding_tax, :consumption_tax, :transport, :accommodation, :carriage, :equipment, :other_expenses, :card, :transfer_fee, :payment_options, :payment_due, :paid, :charged_at, :recieved_at, :stripeToken, :_destroy, :id],
      review_attributes: [:reviewee, :reviewer, :total_review, :quality, :confortability, :cost_performance, :manners, :fast_response, :comment, :report, :feedback, :_destroy, :id],
      cancelled_offer_attributes: [:cancelled_by, :cause, :payback_rate, :paid_to_client, :pay_amount_to_client, :paid_to_performer, :pay_amount_to_performer, :_destroy, :id]
      )
  end

  def cancel_params
    params.require(:offer).permit(
      :offer_status, :last_update_from,
      cancelled_offer_attributes: [:recieved_amount, :deposit_for_performer, :cancelled_by, :cause, :payback_rate, :paid_to_client, :pay_amount_to_client, :paid_to_performer, :pay_amount_to_performer, :profit, :_destroy, :id]
      )
  end

	def message_params
		params.require(:chat_message).permit(:contact_id, :offer_id, :from, :to, :body)
	end

#データのセッティング
  def set_new_offer
    @offer = Offer.new
    @offer.client = @offer.user_id = @offer.last_update_from = params[:user]
    @offer.contractor = params[:contractor]
    @offer.offered_performer = params[:offered_performer]
    @offer.offer_status = 0
    @offer.build_contact(performer: @offer.offered_performer, user1: @offer.client , user2: @offer.contractor, user_id: @offer.user_id)
    @offer.save
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def get_users
    @client = User.find(@offer.client)
    @contractor = User.find(@offer.contractor)
    @last_updater = User.find(@offer.last_update_from)
    @performer = PerformerProfile.find(@offer.offered_performer)
  end

	def set_chat(offer)
    begin
    	@contact = Contact.find_by(offer_id: offer.id)
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
    rescue
    end
  end

#オファー有効期限(見積り承認1週間後か本番の銀行2営業日前のうち、早い方の15時まで)
  def offer_expiration(meeting_time)
    expiration = 3.business_days.before(meeting_time) #本番3営業日前
    return expiration.end_of_day
  end

#Offer#Updateでデータ保存前に行う処理
  def before_update(offer)
    offer.offer_status = change_offer_status(offer)
    unless current_user.admin == true
      offer.last_update_from = current_user.id
    end
  end

  def before_cancel(offer)
    unless current_user.admin == true
      offer.last_update_from = current_user.id
    end
    offer.assign_attributes(cancel_params)
  end

#Offer#Updateでデータ保存後の処理 可読性より分岐を1回で済ますことを優先。
  def after_updated(offer)
    case offer.offer_status
    when 1 #新規オファー
      OfferMailer.with(offer: offer).new_offer.deliver_later
      OfferExpirationJob.set(wait_until: offer_expiration(offer.meeting_time)).perform_later(offer)
      redirect_to offer_path(offer), notice: "パフォーマーに新規オファーを出しました。"
    when 2 #オファー内容変更
      OfferMailer.with(offer: offer).offer_changed.deliver_later
      redirect_to offer_path(offer), notice: "オファーの内容を変更しました。"
    when 3 #パフォーマーよりオファーが断られた場合
      OfferMailer.with(offer: offer).performer_unaccepted.deliver_later
      redirect_to offer_path(offer), notice: "このオファーを見送りました。"
    when 4 #パフォーマーが依頼を受け、見積りを出した場合
      OfferMailer.with(offer: offer).estimation_to_client.deliver_later
      redirect_to offer_path(offer), notice: "クライアントに見積りを送りました。"
    when 5 #クライアントより再見積り依頼が来た場合
      OfferMailer.with(offer: offer).re_estimate_order.deliver_later
      redirect_to offer_path(offer), notice: "パフォーマーに再見積りを依頼しました。"
    when 6 #クライアントよりオファーが断られた場合
      OfferMailer.with(offer: offer).client_unaccepted.deliver_later
      redirect_to offer_path(offer), notice: "このオファーを見送りました。"
    when 7 #クライアントが見積りを承認し、オファーが成立した場合
      #アクションはpayments_controller#newで実行
      redirect_to new_payment_path(offer, id: offer.id, estimation: offer.estimation), notice: "このオファーを承認しました。"
    when 8 #クライアントが見積りを承認し、オファーが成立した場合
      redirect_to payment_confirmation_path(offer)
    when 9 #クライアントが見積りを承認し、オファーが成立した場合
      if offer.payment.payment_options == 1
        create_charge(offer.id, offer.payment.total)
      end
      OfferMailer.with(offer: offer).charge_created.deliver_later
      redirect_to offer_path(offer),  notice: "ありがとうございます。入金確認後オファーが確定します。"
    #10、11、12 アクションなし
    when 13 #クライアントが支払を完了し、Adminがそれを確認してステータスを変更した場合
      OfferMailer.with(offer: offer).offer_confirmed_to_client.deliver_later
      OfferMailer.with(offer: offer).offer_confirmed_to_contractor.deliver_later
      FinishedOfferJob.set(wait_until: offer.release_time).perform_later(offer)
      redirect_to root_path, notice: "お支払いが完了しました。"
    when 14, 15, 16
      OfferMailer.with(offer: offer).offer_cancelled_to_client.deliver_later
      OfferMailer.with(offer: offer).offer_cancelled_to_contractor.deliver_later
      OfferMailer.with(offer: offer).offer_cancelled_to_admin.deliver_later
      redirect_to offer_path(offer), notice: "このオファーをキャンセルしました。"
    #17 オファー完了はFinishedOfferJobで実行されるメールで、Offers#Showに飛ばしてレビューページに飛ばしている
    when 18
      ReviewMailer.with(offer: @offer).to_admin.deliver_later
      ReviewMailer.with(offer: @offer).to_contractor.deliver_later
      ReviewMailer.with(offer: @offer).to_client.deliver_later
      redirect_to offer_path(offer), notice: "ありがとうございます。レビューを送信しました。"

    when 20
      redirect_to root_path, notice: "クライアントとパフォーマーへの払戻が完了しました。"
    else
      redirect_to offer_path(offer), notice: "オファーの内容を変更しました。"
    end
  end

#フォームの更新に伴うオファーステータスの変更
  def change_offer_status(offer)
    begin
      if current_user.id == offer.client
        case offer.offer_status
        when 0
          return 1
        when 1
          return 2
        else
          return offer.offer_status #ステータス変更なし
        end
      elsif current_user.id == offer.contractor
        case offer.offer_status
        when 1, 2, 5
          return 4
        else
          return offer.offer_status #ステータス変更なし
        end
      end
    rescue
      return offer.offer_status #ステータス変更なし
    end
  end

# stripeの支払い
  def create_charge(offer_id, pay_amount)
    token = params[:stripeToken]
    source = params[:stripeTokenType]
    Stripe::Charge.create(
      :amount => pay_amount,
      :currency => "jpy",
      :source => token,
      :description => "オファーID: " + offer_id.to_s + " - クライアントからのオファー支払い"
    )
  end

end
