class PerformerProfilesController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :certified_user_only, except: [:show]
  before_action :admin_only, only: [:admin_check, :admin_approval]
  before_action :performer_only, except: [:show, :admin_check, :admin_approval]
  before_action :user_check, only: [:index]
  before_action :set_performer, except: [:new, :index]

    def index
      @groups = @user.performer_profiles.all
    end

    def new
      set_current_user
      if @user.performer_profiles.all.length > Constants::MAX_GROUPS
        redirect_to mygroups_path(current_user), notice: "#{Constants::MAX_GROUPS}グループ以上は登録できません。"
      end
      #performer_profileをビルドしてcreateを介さずeditにリダイレクト 他にいい方法あればそうしたい
      @performer_profile = @user.performer_profiles.build
      if @performer_profile.save
        redirect_to edit_performer_profile_path(@performer_profile)
      end
    end

    def create
    end

    def show
      @groups = PerformerProfile.where(user_id: @performer_profile.user_id).where.not(id: @performer_profile.id)
      @donators = Donation.where(livehouse_id: @performer_profile.id).limit(100)
      @favorite_status = FavoritePerformer.where(user_id: current_user, performer: @performer_profile.id).present?
      @number_of_favorites = FavoritePerformer.where(performer: @performer_profile.id).length
      write_recently_viewed_performer_cookies(@performer_profile)
    end

    def edit
      unless @performer_profile.user_id === current_user.id
        redirect_to dashboard_path(current_user), notice: "指定されたURLにはアクセスできません"
      end
    end

    def update
      if @performer_profile.update(performer_params)
        PerformerRegistrationMailer.with(performer_profile: @performer_profile).admin.deliver_later
        PerformerRegistrationMailer.with(performer_profile: @performer_profile).user.deliver_later
        redirect_to mygroups_path(current_user), notice: "プロフィールを変更しました。"
      else
        render "edit"
      end
    end

    def destroy
      if @performer_profile.destroy
        redirect_to mygroups_path(current_user), notice: "このグループを削除しました。"
      end
    end

    def admin_check
      @performer_profile = PerformerProfile.find(params[:id])
      @user = User.find(@performer_profile.user_id)
    end

    def admin_approval
      if @performer_profile.update(performer_params)
        PerformerRegistrationMailer.with(performer_profile: @performer_profile).admin_approved.deliver_later
        PerformerRegistrationMailer.with(performer_profile: @performer_profile).user_approved.deliver_later
        redirect_to root_path, notice: "このパフォーマーを承認しました。"
      else
        render "edit"
      end
    end

  private

    def set_performer
      @performer_profile = PerformerProfile.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :_destroy, :id,
        performer_profiles_attributes: [:user_id, :performer_name, :performer_rank, :genre, :zipcode, :pref, :city, :street, :bldg, :shop_email, :shop_phone, :shop_url, :company, :owner, :manager, :music_genre_list, :area, :number_of_member, :set_of_instruments, :instrument_list, :profile_short, :profile_long, :basic_guarantee, :conditions, :conditions_detail, :sample_movie_url1, :sample_movie_url2, :sample_movie_url3, :profile_photo, :cover_photo, :profile_photo_cache, :cover_photo_cache, :certified, :published, :_destroy, :id]
        )
    end

    def performer_params
      params.require(:performer_profile).permit(
        :performer_name, :performer_rank, :zipcode, :pref, :city, :street, :bldg, :shop_email, :shop_phone, :shop_url, :company, :owner, :manager, :genre, :music_genre_list, :area, :number_of_member, :set_of_instruments, :instrument_list, :profile_short, :profile_long, :basic_guarantee, :conditions, :conditions_detail, :sample_movie_url1, :sample_movie_url2, :sample_movie_url3, :profile_photo, :cover_photo, :profile_photo_cache, :cover_photo_cache, :certified, :published, :_destroy, :id,
      )
    end

    def write_recently_viewed_performer_cookies(performer)
      #クッキーを配列に保存
        cookies[:recently_viewed_performers] ||= [].push(performer.id).join(',')
        recently_viewed_performers_array = cookies[:recently_viewed_performers].split(',').unshift(performer.id).map!(&:to_i).uniq
        recently_viewed_performers_array.pop if recently_viewed_performers_array.length > 10
        cookies[:recently_viewed_performers] = recently_viewed_performers_array.join(',')
    end

end
