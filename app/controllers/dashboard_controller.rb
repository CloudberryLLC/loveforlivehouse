class DashboardController < ApplicationController

	include ProfilesHelper, DonationsHelper

	before_action :authenticate_user!
  before_action :user_check

  def show
		set_data
  end

private
	def set_data
		@user = current_user
		@recent_viewed_livehouses = cookies[:recently_viewed_livehouses].split(',') if cookies[:recently_viewed_livehouses]
		@donations = Donation.where(supporter_id: @user.id, paid: true).page(params[:page]).per(10)
	end

end
