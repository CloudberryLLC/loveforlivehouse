class InvoicesController < ApplicationController

	before_action :authenticate_user!
  before_action :certified_user_only

  def show
		begin
	    @offer = Offer.find(params[:id])
	    @payment = @offer.payment
			@performer = PerformerProfile.find(@offer.offered_performer)

	    if current_user.id == @offer.client
	      @user = User.find(@offer.client)
	    elsif current_user.id == @offer.contractor
	      @user = User.find(@offer.contractor)
	    else
	      redirect_to root_path, notice: "そのページは存在しません"
	    end
		rescue
			head :not_found
		end
  end

end
