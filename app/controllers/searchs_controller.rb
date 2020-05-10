class SearchsController < ApplicationController
  def index
    keyword = params[:keyword]
    @livehouses = Livehouse.where(
      ['livehouse_name LIKE? or area LIKE? or genre LIKE?',
        "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"]
      ).where(certified: true).where(published: true).page(params[:page]).per(30)
  end

private

  def search_params
    params.require(:search).permit(:keyword)
  end

end
