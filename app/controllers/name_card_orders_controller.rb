class NameCardOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :order_confirmation, :order_confirmed]

  def index
  end

  def new
    set_new_order
    if @order.save
      redirect_to edit_name_card_order_path(@order)
    end
  end

  def create
  end

  def show
    redirect_to edit_name_card_order_path(@order)
  end

  def edit
  end

  def update
    add_price_and_payment_limit
    if @order.update(order_params)
      redirect_to name_card_order_confirmation_path(@order)
    else
      render 'edit'
    end
  end

  def destroy
  end

  def order_confirmation

  end

  def order_confirmed
    if @order.payment_option == 1
      create_charge(@order, @order.price)
    end
    NameCardOrderMailer.with(name_card_order: @order).order_confirmed.deliver_later
    NameCardOrderMailer.with(name_card_order: @order).coming_order.deliver_later
    redirect_to mygroups_path(current_user), notice: "オーダーを完了しました"
  end

private
  def set_order
    @order = NameCardOrder.find(params[:id])
    @namecard = NameCard.find(@order.name_card_id)
    @performer = PerformerProfile.find(@namecard.performer_profile_id)
    @customer = User.find(@performer.user_id)
  end

  def set_new_order
    @namecard = NameCard.find(params[:id])
    @performer = PerformerProfile.find(@namecard.performer_profile_id)
    @customer = User.find(@performer.user_id)
    @order = @namecard.name_card_orders.build(
      :reciever_name => @customer.basic.lastname + " " + @customer.basic.firstname,
      :zipcode => @customer.basic.zipcode,
      :pref => @customer.basic.pref,
      :city => @customer.basic.city,
      :street => @customer.basic.street,
      :bldg => @customer.basic.bldg,
      :delivery_date => Date.today + 7.day
    )
  end

  def add_price_and_payment_limit
    @order.price = set_price(params[:name_card_order][:amount])
    @order.payment_limit = @order.created_at + 2.days
  end

  def order_params
    params.require(:name_card_order).permit(:amount, :delivery_date, :price, :payment_option, :payment_limit, :paid, :zipcode, :pref, :city, :street, :bldg, :reciever_name, :ordered, :_destroy, :id)
  end

  def set_price(amount)
    case amount.to_i
    when 100
      return 2500
    when 200
      return 4000
    end
  end

#stripeの支払い
  def create_charge(order, price)
    token = params[:stripeToken]
    source = params[:stripeTokenType]
    Stripe::Charge.create(
      :amount => price,
      :currency => "jpy",
      :source => token,
      :description => "名刺オーダーID: " + order.id.to_s + " - 名刺作成代金"
    )
  end

end
