class LivehousesController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :certified_user_only, except: [:show]
  before_action :admin_only, only: [:admin_check, :admin_approval]
  before_action :livehouse_only, except: [:show, :admin_check, :admin_approval]
  before_action :user_check, only: [:index]
  before_action :set_livehouse, except: [:new, :index]

    def index
      @groups = @user.livehouses.all
    end

    def new
      set_current_user
      if @user.livehouses.all.length > Constants::MAX_GROUPS
        redirect_to mygroups_path(current_user), notice: "#{Constants::MAX_GROUPS}グループ以上は登録できません。"
      end
      #livehouseをビルドしてcreateを介さずeditにリダイレクト 他にいい方法あればそうしたい
      @livehouse = @user.livehouses.build
      if @livehouse.save
        redirect_to edit_livehouse_path(@livehouse)
      end
    end

    def create
    end

    def show
      @groups = Livehouse.where(user_id: @livehouse.user_id).where(certified: true, published: true).where.not(id: @livehouse.id)
      @donators = Donation.where(livehouse_id: @livehouse.id).limit(100)
      write_recently_viewed_livehouse_cookies(@livehouse)
    end

    def edit
      unless @livehouse.user_id === current_user.id
        redirect_to dashboard_path(current_user), notice: "指定されたURLにはアクセスできません"
      end
    end

    def update
      if @livehouse.update(livehouse_params)
        LivehouseRegistrationMailer.with(livehouse: @livehouse).admin.deliver_later
        LivehouseRegistrationMailer.with(livehouse: @livehouse).user.deliver_later
        redirect_to mygroups_path(current_user), notice: "プロフィールを変更しました。"
      else
        render "edit"
      end
    end

    def destroy
      if @livehouse.destroy
        redirect_to mygroups_path(current_user), notice: "このグループを削除しました。"
      end
    end

    def admin_check
      @livehouse = Livehouse.find(params[:id])
      @user = User.find(@livehouse.user_id)
    end

    def admin_approval
      if @livehouse.update(livehouse_params)
        LivehouseRegistrationMailer.with(livehouse: @livehouse).admin_approved.deliver_later
        LivehouseRegistrationMailer.with(livehouse: @livehouse).user_approved.deliver_later
        redirect_to root_path, notice: "このライブハウスを承認しました。"
      else
        render "edit"
      end
    end

  private

    def set_livehouse
      @livehouse = Livehouse.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :_destroy, :id,
        livehouses_attributes: [:user_id, :livehouse_name, :genre, :zipcode, :pref, :city, :street, :bldg, :shop_email, :shop_phone, :shop_url, :company, :owner, :manager, :music_genre_list, :area, :instrument_list, :profile_short, :profile_long, :required_amount, :capacity, :conditions_detail, :sample_movie_url1, :sample_movie_url2, :sample_movie_url3, :profile_photo, :cover_photo, :profile_photo_cache, :cover_photo_cache, :certified, :published, :_destroy, :id]
        )
    end

    def livehouse_params
      params.require(:livehouse).permit(
        :livehouse_name, :zipcode, :pref, :city, :street, :bldg, :shop_email, :shop_phone, :shop_url, :company, :owner, :manager, :genre, :music_genre_list, :area, :number_of_member, :instrument_list, :profile_short, :profile_long, :required_amount, :capacity, :conditions_detail, :sample_movie_url1, :sample_movie_url2, :sample_movie_url3, :profile_photo, :cover_photo, :profile_photo_cache, :cover_photo_cache, :certified, :published, :_destroy, :id,
      )
    end

    def write_recently_viewed_livehouse_cookies(livehouse)
      #クッキーを配列に保存
        cookies[:recently_viewed_livehouses] ||= [].push(livehouse.id).join(',')
        recently_viewed_livehouses_array = cookies[:recently_viewed_livehouses].split(',').unshift(livehouse.id).map!(&:to_i).uniq
        recently_viewed_livehouses_array.pop if recently_viewed_livehouses_array.length > 10
        cookies[:recently_viewed_livehouses] = recently_viewed_livehouses_array.join(',')
    end

end
