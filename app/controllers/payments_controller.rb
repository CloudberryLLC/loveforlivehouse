class PaymentsController < ApplicationController

  before_action :authenticate_user!
  before_action :certified_user_only
  before_action :set_current_user
  before_action :admin_only, only: [:admin_check, :admin_approval]

  def new
    set_new_payment
    if @offer.save
      PaymentExpiredJob.set(wait_until: payment_due(@offer.updated_at, @offer.release_time)).perform_later(@offer)
      OfferMailer.with(offer: @offer).estimation_accepted.deliver_later
      OfferMailer.with(offer: @offer).payment_request_to_client.deliver_later
      redirect_to edit_payment_path(@offer.payment)
    end
  end

  def index
  end

  def show
  end

  def create

  end

  def edit
    @payment = Payment.find(params[:id])
    @offer = Offer.find(@payment.offer_id)
    @performer = PerformerProfile.find(@offer.offered_performer)
    @estimation = @offer.estimation
    payable_user?(@offer.client)
  end

  def update
    @payment = Payment.find(params[:id])
  end

  def destroy
  end

  def confirmation
    @offer = Offer.find(params[:id])
    get_users
    payable_user?(@offer.client)
  end

  def admin_check
    @offer = Offer.find(params[:id])
    get_users
  end

private

#ストロングパラメータ
  def offer_params
    params.require(:payment).permit(
      :total, :guarantee, :staff, :management_fee, :staff, :system_fee, :withholding_tax, :consumption_tax, :transport, :accommodation, :carriage, :equipment, :other_expenses, :card, :transfer_fee, :payment_options, :payment_due, :paid, :charged_at, :recieved_at, :stripeToken, :_destroy, :id
      )
  end

#データのセッティング
  def get_users
    @client = User.find(@offer.client)
    @contractor = User.find(@offer.contractor)
    @last_updater = User.find(@offer.last_update_from)
    @performer = PerformerProfile.find(@offer.offered_performer)
  end

  def set_new_payment
    unless @user.user_type == 1
      head :not_found
      return
    end
    @offer = Offer.find(params[:id])
    @estimation = Estimation.find(params[:estimation])
    set_payment_data(@offer, @estimation)
  end

  def set_payment_data(offer, estimation)
    offer.build_payment(
      total: payment_total(estimation),
      guarantee: estimation.guarantee,
      staff: estimation.staff,
      management_fee: 0,
      withholding_tax: estimation.withholding_tax,
      system_fee: estimation.system_fee,
      consumption_tax: calculate_consumption_tax(estimation),
      transport: estimation.transport,
      accommodation: estimation.accommodation,
      carriage: estimation.carriage,
      equipment: estimation.equipment,
      other_expenses: estimation.other_expenses,
      charged_at: DateTime.now,
      payment_due: payment_due(offer.updated_at, offer.release_time)
    )
  end

#正しいユーザー以外支払い方法のページを表示できないようにする。
  def payable_user?(user)
    unless current_user.id == user
      head :not_found
      return
    end
  end

#金額の計算
	def payment_total(estimation)
		total =
    estimation.guarantee.to_i +
		estimation.staff.to_i +
		estimation.withholding_tax.to_i +
		estimation.system_fee.to_i +
		estimation.transport.to_i +
		estimation.accommodation.to_i +
		estimation.carriage.to_i +
		estimation.equipment.to_i +
		estimation.other_expenses.to_i
		return total.to_i
	end

  def calculate_consumption_tax(estimation)
    consumption_tax = (
      estimation.guarantee.to_i +
      estimation.staff.to_i +
      estimation.withholding_tax.to_i +
      estimation.system_fee.to_i) / ( 1 + Constants::SALES_TAX ) * Constants::SALES_TAX
    return consumption_tax
  end

end
