class DashboardController < ApplicationController

	before_action :authenticate_user!
  before_action :user_check

	include ProfilesHelper

  def show
		set_data
  end

private
	def set_data
		@user = current_user
		@favorites = FavoritePerformer.where('user_id = ?', current_user.id).page(params[:page]).per(10)
		@recent_viewed_performers = cookies[:recently_viewed_performers].split(',') if cookies[:recently_viewed_performers]
	end

end
