class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :certified_user_only
  before_action :set_current_user

  def new
    #【バグフィックス】同じユーザーの他レビューが書けてしまう問題をクリアする
    @offer = Offer.find(params[:id])
    if current_user.id == @offer.client
      @reviewer = @offer.client
      @reviewee = @offer.offered_performer
    elsif current_user.id == @offer.contractor
      @reviewer = @offer.offered_performer
      @reviewee = @offer.client
    else
      redirect_to root_path, notice: "不正なアクセスです。"
    end
  end

  def create
    @offer.review = Review.new(review_params)
    if @offer.save
      #performer_review_point(@offer.offered_performer)
      redirect_to dashboard_path(@user)
    end
  end

private

  def review_params
    params.require(:review).permit(:reviewee, :reviewer, :total_review, :quality, :confortability, :manners, :fast_response, :comment, :report, :feedback)
  end

  #performer_profilesの評価値を更新
  def performer_review_point(performer_id)
    @performer_profile=PerformerProfile.find(performer_id)
    @reviews = Review.where('reviewee = ?', @performer_profile.id)
    @performer_profile.review_point = @reviews.average(:total_review).round(2)
    @performer_profile.save
  end

end
