class NameCardsController < ApplicationController
  before_action :authenticate_user!
  before_action :performer_only
  before_action :set_performer, only: [:new, :edit]

  def new
    unless @performer.name_card.present?
    @performer.build_name_card.save
    end
    redirect_to edit_name_card_path(id: @performer)
  end

  def create
  end

  def edit
    @namecard = NameCard.find_by(performer_profile_id: @performer)
  end

  def update
    @namecard = NameCard.find(params[:id])
    if @namecard.update(namecard_params)
      redirect_to new_name_card_order_path(id: @namecard)
    end
  end

  def show
  end

  def index
  end

  def destroy
  end

private

  def set_performer
    @performer = PerformerProfile.find(params[:id])
  end

  def namecard_params
    params.require(:name_card).permit(:your_part, :your_name, :your_name_kana, :your_group, :_destroy, :id)
  end

#stripeの支払い
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
