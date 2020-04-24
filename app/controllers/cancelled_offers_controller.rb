class CancelledOffersController < ApplicationController

  before_action :authenticate_user!
  before_action :certified_user_only
  before_action :set_current_user
  before_action :set_data, except: [:index]
  before_action :admin_only, only: [:index, :admin_payback, :payback_approval]

  def index
    @cancelled_offers = CancelledOffer.all.limit(400).order("created_at DESC").page(params[:page]).per(25)
  end

  def new
    set_new_data
    @offer.build_cancelled_offer(
      recieved_amount: @recieved_amount,
      deposit_for_performer: @deposit_for_performer
    ).save
    redirect_to edit_cancelled_offer_path(@offer)
  end

  def create
    if @offer.save(cancelled_offer_params)
      redirect_to offer_path(@offer), notice: 'このオファーをキャンセルしました。'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @offer.save!(cancelled_offer_params)
      redirect_to offer_path(@offer), notice: 'このオファーをキャンセルしました。'
    end
  end

  def destroy
  end

  def admin_payback
  end

private

  def cancelled_offer_params
    params.require(:offer).permit(
      :offer_status, :id, :_destroy,
      cancelled_offer_attributes: [:recieved_amount, :deposit_for_performer, :cancelled_by, :cause, :payback_rate, :paid_to_client, :pay_amount_to_client, :paid_to_performer, :pay_amount_to_performer, :profit, :_destroy, :id]
      )
  end

  def set_new_data
    @recieved_amount = @payment.total
    @deposit_for_performer = @payment.total - @payment.system_fee
  end

  def set_data
    @offer = Offer.find(params[:id])
    @payment = @offer.payment
    @client = User.find(@offer.client)
    @contractor = User.find(@offer.contractor)
    @last_updater = User.find(@offer.last_update_from)
    @performer = PerformerProfile.find(@offer.offered_performer)
  end

end
