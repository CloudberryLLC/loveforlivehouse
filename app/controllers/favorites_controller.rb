class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_data, only:[:clip]

  def clip
    unless FavoritePerformer.where(user_id: @user.id, performer: @performer.id).present?
      @favorite = FavoritePerformer.new(user_id: @user.id, performer: @performer.id, favorite: true)
      @favorite.save!
    else
      @favorite = FavoritePerformer.where(user_id: @user.id, performer: @performer.id)
      FavoritePerformer.destroy(@favorite.ids)
    end
    redirect_to performer_path(@performer)
  end

  def index
    @favorites = FavoritePerformer.where(user_id: current_user.id)
  end

private
  def clip_params
    params.permit(:user_id, :performer, :favorite, :id, :_destroy)
  end

  def set_data
    @user = current_user
    @performer = PerformerProfile.find(params[:performer])
    @number_of_favorites = FavoritePerformer.where(performer: @performer.id).length
  end
end
