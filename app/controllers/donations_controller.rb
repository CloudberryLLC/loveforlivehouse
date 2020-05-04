class DonationsController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!, only: [:index]
  before_action :admin_only, only: [:index]

  def new
    begin
      @livehouse_id = decode_livehouse_id(params[:id])
      @livehouse =  PerformerProfile.find(@livehouse_id)
      set_new_donation
    rescue
      head :bad_request
    end
  end

  def create
    @donation = Donation.create(donation_params)
    @livehouse = PerformerProfile.find(@donation.livehouse_id)
    @donation.reciever = @livehouse.user_id
    @donation.paid = false
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
    if create_charge(@donation)
      @donation.paid = true
      @donation.save!
      redirect_to performer_path(@donation.livehouse_id), notice: "ありがとうございます。お支払いが正常に行われました。"
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

end
