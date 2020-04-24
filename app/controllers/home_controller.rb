class HomeController < ApplicationController
  def index
    @new_performers = PerformerProfile.where(published: true).where.not(performer_rank: 3).limit(20).order("created_at DESC")
    @recent_viewed_performers = cookies[:recently_viewed_performers].split(',') if cookies[:recently_viewed_performers]
  end
end
