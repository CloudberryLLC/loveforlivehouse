class RecieptsController < ApplicationController

  before_action :authenticate_user!
  before_action :certified_user_only

  def show
    begin
      @donation = Donation.find(params[:id])
      @title = params[:text]
      if livehouse?
        @user = User.find(@offer.supporter)
        @as_a = "サービス利用料"
      end
      if supporter?
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
