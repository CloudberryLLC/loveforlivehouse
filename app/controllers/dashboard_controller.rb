class DashboardController < ApplicationController

	before_action :authenticate_user!
  before_action :user_check

  def show
		set_data
  end

private
	def set_data
		@user = current_user
  	@offers = Offer.where('client = ? or contractor = ?', current_user.id, current_user.id).limit(3).page(params[:page]).per(3)
		@favorites = FavoritePerformer.where('user_id = ?', current_user.id).page(params[:page]).per(10)
		@recent_viewed_performers = cookies[:recently_viewed_performers].split(',') if cookies[:recently_viewed_performers]
	end

end
