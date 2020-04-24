class ProfilesController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_only, only: [:admin_check, :admin_approval]
  before_action :user_check, except: [:show, :admin_check, :admin_approval]

  def new
  end

  def create
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    @user.certified = false
    if @user.update(user_params)
      UserProfileCertificationMailer.with(user: @user).send_admin.deliver_later
      UserProfileCertificationMailer.with(user: @user).send_user.deliver_later
      redirect_to dashboard_path(current_user), notice: "プロフィールを変更しました。"
    else
      render "edit"
    end
  end

  def destroy
  end

  def admin_check
    @user = User.find(params[:id])
  end

  def admin_approval
    @user = User.find(params[:id])
    if @user.update(user_params)
      UserProfileCertificationMailer.with(user: @user).admin_approved.deliver_later
      UserProfileCertificationMailer.with(user: @user).user_approved.deliver_later
      redirect_to root_path, notice: "このユーザーを承認しました。"
    else
      render "edit"
    end
  end

  private

    def user_params
      params.require(:user).permit(
        :email, :user_type, :certified,
        basic_attributes: [:lastname, :lastname_kana, :firstname, :firstname_kana, :company, :department, :phone, :zipcode, :pref, :city, :street, :bldg, :profile_photo, :cover_photo, :id_front, :id_back, :company_certification, :_destroy, :id],
        bank_attributes: [:bank_name, :bank_branch, :bank_branch_code, :bank_type, :bank_number, :bank_owner, :bank_owner_kana, :_destroy, :id],
        musician_profile_attributes: [:musician_name, :musician_class,:instrument1, :instrument2, :profile_photo, :cover_photo, :profile_short, :profile_long, :sample_movie_url1, :sample_movie_url2, :sample_movie_url3, :basic_guarantee, :play_condition, :play_condition_detail, :area, :_destroy, :id]
        )
    end

  end
