class DonationsController < ApplicationController

  include ApplicationHelper, DonationsHelper

  skip_before_action :verify_authenticity_token, only: [:stripe_webhook]
  before_action :authenticate_user!, only: [:index]
  before_action :admin_only, only: [:index]
  before_action :set_data, only: [:show, :edit, :update, :confirmation]

  def index
  end

  def show
    head :not_found unless donation_token(@donation) == params[:hash]
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
    @donation.update_count = 1
    set_subdata
    if @donation.save
      redirect_to donation_confirmation_path(id: @donation.id, hash: donation_token(@donation))
    else
      render 'new', alart: "保存に失敗しました"
    end
  end

  def edit
    head :internal_server_error unless params[:hash] == donation_token(@donation) #500
    head :bad_request if @donation.paid == true
  end

  def update
    @donation.update_count += 1
    if @donation.update(donation_params)
      redirect_to donation_confirmation_path(hash: donation_token(@donation), id: @donation.id)
    else
      render 'edit', alart: "保存に失敗しました"
    end
  end

  def confirmation
    if @donation.paid == true
      redirect_to donation_path(hash: donation_token(@donation), id: @donation.id)
    end
    if @donation.payment_intent_id.blank?
      create_paymentIntent(@donation, @user)
    else
      update_paymentIntent(@donation, @user)
    end
  end

  def payment_succeeded
    @donation = Donation.find(params[:id])
    update_paid_status(@donation)
  end

  def stripe_webhook
    perform_webhook
  end



private

  def donation_params
    params.require(:donation).permit(
      :nickname, :amount, :message, :name, :email, :phone, :zipcode, :pref, :city, :street, :bldg, :confirmation, :livehouse_id, :supporter_id, :update_count, :stripeToken
      )
  end

  def set_new_donation
    if livehouse_hash(@livehouse) == params[:hash]
      @donation = Donation.new( :livehouse_id => @livehouse_id )
      if user_signed_in? && current_user.basic.present?
        user = current_user.basic
        @donation.name = show_company(user.company) + user.lastname + " " + user.firstname
        @donation.email = current_user.email
        @donation.phone = user.phone
        @donation.zipcode = user.zipcode
        @donation.pref = user.pref
        @donation.city = user.city
        @donation.street = user.street
        @donation.bldg = user.bldg
      end
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
    @donation.paid = false unless @donation.paid == true
    if user_signed_in?
      @donation.supporter_id = current_user.id
    end
  end

  def show_company(company)
    return "" if company == "なし"
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
        description: @livehouse.livehouse_name.to_s + "への、ライブハウス緊急支援サイト「LOVE for Live House」を通じたご寄付 (支援ID: " + donation.id.to_s + ")",
        metadata: { donation_id: donation.id },
        },
        stripe_account: user.stripe_user_id)
      unless donation.payment_intent_id.present?
        donation.payment_intent_id = @payment_intent.id
        donation.save!
      end
    rescue Stripe::InvalidRequestError => e
      flash.now[:error] = "決済(stripe)でエラーが発生しました（InvalidRequestError）#{e.message}"
      render :new
    rescue
      flash.now[:error] = "エラーが発生しました(code:512)"
    end
  end

  def update_paymentIntent(donation, user)
    begin
      @payment_intent = Stripe::PaymentIntent.retrieve(donation.payment_intent_id, stripe_account: user.stripe_user_id)
      unless @payment_intent.status == "succeeded"
        @payment_intent = nil
        @payment_intent = Stripe::PaymentIntent.update(donation.payment_intent_id, {
          amount: donation.amount.to_i,
          application_fee_amount: (donation.amount * Constants::SYSTEM_FEE).ceil.to_i,
          receipt_email: donation.email,
          },
          stripe_account: user.stripe_user_id)
      end
    rescue Stripe::InvalidRequestError => e
      flash.now[:error] = "決済(stripe)でエラーが発生しました（InvalidRequestError）#{e.message}"
      render :new
    rescue
      flash.now[:error] = "エラーが発生しました(code:513)"
    end
  end

  def perform_webhook
    endpoint_secret = Rails.application.credentials.STRIPE_WEBHOOK_ENDPOINT_SECRET
    payload = request.body.read
    event = nil
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      head :bad_request # Invalid payload
      return
    rescue Stripe::SignatureVerificationError => e
      head :bad_request # Invalid signature
      return
    end
    if event['type'] == 'payment_intent.succeeded'
      @donation = Donation.find(event['data']['object']['metadata']['donation_id'])
      update_paid_status(@donation)
      head :ok
    end
  end

  def update_paid_status(donation)
    @livehouse = Livehouse.find(donation.livehouse_id)
    collection_whole_period = Donation.where(livehouse_id: @livehouse.id, paid: true)
    collection_this_month = collection_whole_period.where(updated_at: DateTime.now.in_time_zone.all_month)
    donation.paid = true
    if donation.save
      @livehouse.donators_whole_period = collection_whole_period.count
      @livehouse.funded_whole_period = collection_whole_period.all.sum(:amount)
      @livehouse.donators_this_month = collection_this_month.count
      @livehouse.funded_this_month = collection_this_month.all.sum(:amount)
      @livehouse.save!
    end
  end

end
