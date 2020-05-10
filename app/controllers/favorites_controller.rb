class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_data, only:[:clip]

  def clip
    unless FavoriteLivehouse.where(user_id: @user.id, livehouse: @livehouse.id).present?
      @favorite = FavoriteLivehouse.new(user_id: @user.id, livehouse: @livehouse.id, favorite: true)
      @favorite.save!
    else
      @favorite = FavoriteLivehouse.where(user_id: @user.id, livehouse: @livehouse.id)
      FavoriteLivehouse.destroy(@favorite.ids)
    end
    redirect_to livehouse_path(@livehouse)
  end

  def index
    @favorites = FavoriteLivehouse.where(user_id: current_user.id)
  end

private
  def clip_params
    params.permit(:user_id, :livehouse, :favorite, :id, :_destroy)
  end

  def set_data
    @user = current_user
    @livehouse = Livehouse.find(params[:livehouse])
    @number_of_favorites = FavoriteLivehouse.where(livehouse: @livehouse.id).length
  end
end
