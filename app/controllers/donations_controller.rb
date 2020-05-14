class DonationsController < ApplicationController

  include ApplicationHelper, DonationsHelper

  before_action :authenticate_user!, only: [:index]
  before_action :admin_only, only: [:index]
  before_action :set_data, only: [:show, :edit, :update, :confirmation, :charge]

  def index
  end

  def show
  end

  def new
    begin
      @livehouse_id = decode_livehouse_id(params[:id])
      @livehouse =  Livehouse.find(@livehouse_id)
      set_new_donation
    rescue
      head :internal_server_error #500
    end
  end

  def create
    @donation = Donation.create(donation_params)
    set_subdata
    if @donation.save
      redirect_to donation_confirmation_path(id: @donation.id, hash: donation_token(@donation))
    else
      render 'new', alart: "保存に失敗しました"
    end
  end

  def edit
    unless params[:hash] == donation_token(@donation)
      head :internal_server_error #500
    end
  end

  def update
    if @donation.update(donation_params)
      redirect_to donation_confirmation_path(id: @donation.id, hash: donation_token(@donation))
    else
      render 'edit', alart: "保存に失敗しました"
    end
  end

  def confirmation
    if @donation.paid == true
      redirect_to donation_path(@donation)
    end
    if @donation.save
      create_paymentIntent(@donation, @user)
    else
      render 'new', alart: "エラーが発生しました。繰り返し発生する場合はサポートにお尋ねください。"
    end
  end

  def charge
    create_paymentIntent(@donation, @user)
    @donation.paid
    if @donation.save
      redirect_to donation_path(@donation), notice: "ありがとうございます。お支払いが正常に行われました。"
    else
      render 'new', alart: "エラーが発生しました。繰り返し発生する場合はサポートにお尋ねください。"
    end
  end

private

  def donation_params
    params.require(:donation).permit(
      :uid, :nickname, :amount, :message, :name, :email, :phone, :zipcode, :pref, :city, :street, :bldg, :confirmation, :livehouse_id, :supporter_id, :stripeToken
      )
  end

  def set_new_donation
    if livehouse_hash(@livehouse) == params[:hash]
      @donation = Donation.new( :livehouse_id => @livehouse_id )
    else
      head :bad_request
    end
  end

  def set_data
    @donation = Donation.find(params[:id])
    set_subdata
  end

  def set_subdata
    @livehouse = Livehouse.find(@donation.livehouse_id)
    @livehouse_id = @livehouse.id
    @user = User.find(@livehouse.user_id)
    
    @donation.reciever = @livehouse.user_id
    @donation.paid = false
    @donation.phone = "なし" if @donation.phone.blank?
    @donation.zipcode = "なし" if @donation.zipcode.blank?
    @donation.pref = "なし" if @donation.pref.blank?
    @donation.city = "なし" if @donation.city.blank?
    @donation.street = "なし" if @donation.street.blank?
    @donation.bldg = "建物名なし" if @donation.bldg.blank?

    if user_signed_in?
      @donation.supporter_id = current_user.id
    end
  end

#stripeの支払い
  def create_paymentIntent(donation, user)
    begin
      @payment_intent = Stripe::PaymentIntent.create({
        payment_method_types: ["card"],
        amount: donation.amount.to_i,
        currency: "jpy",
        application_fee_amount: (donation.amount * Constants::SYSTEM_FEE).ceil.to_i,
        receipt_email: donation.email,
        description: "支援ID: " + donation.id.to_s,
      }, stripe_account: user.stripe_user_id)
    rescue Stripe::InvalidRequestError => e
      flash.now[:error] = "決済(stripe)でエラーが発生しました（InvalidRequestError）#{e.message}"
      render :new
    end
  end

end
