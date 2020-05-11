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
		@recent_viewed_livehouses = cookies[:recently_viewed_livehouses].split(',') if cookies[:recently_viewed_livehouses]
		@donations = Donation.where(supporter_id: @user.id)
	end

end
