class DonationsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!, only: [:index]
  before_action :admin_only, only: [:index]

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
    @livehouse = Livehouse.find(@donation.livehouse_id)
    @user = User.find(@livehouse.user_id)
    @donation.reciever = @livehouse.user_id
    @donation.paid = false
    create_paymentIntent(@donation, @user)
    if @donation.save
    else
      render 'new'
    end
  end

  def index
  end

  def show
    @donation = Donation.find(params[:id])
  end

  def update
    @donation = Donation.find(params[:id])
    @livehouse = Livehouse.find(@donation.livehouse_id)
    @user = User.find(@livehouse.user_id)
    @donation.paid = true
    if @donation.save
      #create_paymentIntent(@donation, @user)
      #redirect_to livehouse_path(@donation.livehouse_id), notice: "ありがとうございます。お支払いが正常に行われました。"
    else
      render 'create'
    end
  end

private

  def donation_params
    params.require(:donation).permit(
      :nickname, :amount, :message, :name, :email, :phone, :zipcode, :pref, :city, :street, :bldg, :confirmation, :livehouse_id, :stripeToken
      )
  end

  def set_new_donation
    if livehouse_hash(@livehouse) == params[:hash]
      @donation = Donation.new( :livehouse_id => @livehouse_id )
    else
      head :bad_request
    end
  end

#stripeの支払い
  def create_charge(donation)
    source = params[:stripeTokenType]
    Stripe::Charge.create(
      amount: donation.amount,
      currency: "jpy",
      source: params[:stripeToken],
      description: "支援ID: " + donation.id.to_s + " - 様からの寄付"
    )
  end

  def create_paymentIntent(donation, user)
    begin
      @payment_intent = Stripe::PaymentIntent.create({
        payment_method_types: ["card"],
        amount: donation.amount.to_i,
        currency: "jpy",
        application_fee_amount: (donation.amount * Constants::SYSTEM_FEE).ceil.to_i,
        description: "支援ID: " + donation.id.to_s,
      }, stripe_account: user.stripe_user_id)
    rescue Stripe::InvalidRequestError => e
      flash.now[:error] = "決済(stripe)でエラーが発生しました（InvalidRequestError）#{e.message}"
      render :new
    end
  end

end
