class SearchsController < ApplicationController
  def index
    #sort = params[:sort] || "created_at DESC"
    @keyword = params[:keyword]

    if @keyword.present?
      @livehouses = []

      @keyword.split(/[[:blank:]]+/).each do |keyword|
        next if keyword == ""
        @livehouses += Livehouse.where(
          ['livehouse_name LIKE? or area LIKE? or genre LIKE?',
            "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"]
          ).where(certified: true, published: true).order("created_at DESC").page(params[:page]).per(30)
        @livehouses.uniq!
      end

    else
      @livehouses = Livehouse.order("created_at DESC").limit(30).page(params[:page]).per(30)
    end
  end

private

  def search_params
    params.require(:search).permit(:keyword)
  end

end
