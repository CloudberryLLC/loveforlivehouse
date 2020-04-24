class RecieptsController < ApplicationController

  before_action :authenticate_user!
  before_action :certified_user_only

  def show
    begin
      @offer = Offer.find(params[:id])
      @payment = @offer.payment
      @title = params[:text]
      @request = params[:value] #請求書は1、領収書は2

      if current_user.id == @offer.client
        @user = User.find(@offer.client)
        @as_a = "サービス利用料"
      elsif current_user.id == @offer.contractor
        @user = User.find(@offer.contractor)
        @as_a = "パフォーマンス料"
      else
        redirect_to root_path, notice: "そのページは存在しません"
      end
    rescue
      head :not_found
    end
  end
end
