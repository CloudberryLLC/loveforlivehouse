class DonationsController < ApplicationController
  include ApplicationHelper

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
    if @donation.save
      redirect_to performer_path(@donation.livehouse_id), notice: "このライブハウスに支援を行いました"
    else
      render 'new', alart: "お支払いが失敗しました"
    end
  end

  def index
  end

  def show
  end

private

  def donation_params
    params.require(:donation).permit(
      :nickname, :amount, :message, :name, :email, :phone, :zipcode, :pref, :city, :street, :bldg, :confirmation, :livehouse_id
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
    token = params[:stripeToken]
    source = params[:stripeTokenType]
    Stripe::Charge.create(
      :amount => donation.amount,
      :currency => "jpy",
      :source => token,
      :description => "支援ID: " + donation.id.to_s + " - 様からの寄付"
    )
  end


end
