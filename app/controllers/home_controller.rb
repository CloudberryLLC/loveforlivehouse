class HomeController < ApplicationController
  def index
    @new_livehouses = Livehouse.where(published: true, certified: true).limit(20).order("created_at DESC")
    @recent_viewed_livehouses = cookies[:recently_viewed_livehouses].split(',') if cookies[:recently_viewed_livehouses]
  end
end
