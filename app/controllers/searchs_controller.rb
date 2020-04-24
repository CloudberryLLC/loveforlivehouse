class SearchsController < ApplicationController
  def index
    keyword = params[:keyword]
    @performers = PerformerProfile.where(
      ['performer_name LIKE? or area LIKE? or set_of_instruments LIKE? or genre LIKE?',
        "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"]
      ).where.not(performer_rank: 3).where(published: true).page(params[:page]).per(30)
  end

private

  def search_params
    params.require(:search).permit(:keyword)
  end

end
