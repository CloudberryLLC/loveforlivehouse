class ApplicationController < ActionController::Base

	include ApplicationHelper

	before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?
	
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_path(resource) # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_type, :rule_confirmation])
		#:otp_attemptは2段階認証用
	  devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
  end


	#ActionCableをDeviseで展開させるために使用
	def self.renderer_with_signed_in_user(user)
    ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
    proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap { |i|
      i.set_user(user, scope: :user, store: false, run_callbacks: false)
    }
    renderer.new('warden' => proxy)
	end

	#審査に通ったユーザー以外がアクセスできないページに適用
	def certified_user_only
		unless current_user.certified == true
			redirect_back(fallback_location: :back, alert: '指定されたURLは審査待ちのためアクセスできません')
		end
	end

	#current_userを@userに格納したいときに使用
	def set_current_user
		@user = current_user
	end

	#current_userで@userを定義すると同時に、paramsのユーザIDとcurrent_userが一致しない場合はアクセスを拒否する。
  def user_check
		set_current_user
    unless @user === User.find(params[:id])
			head :not_found
    end
  end

	#admin専用ページに他のアカウントからアクセスした場合にアクセスを遮断する。
	def admin_only
		admin = User.find_by(email: Rails.application.credentials.ADMIN_EMAIL)
		unless current_user === admin
			AdminOnlyMailer.with(user: current_user).failed_login_attempt.deliver_now
			head :not_found
		end
	end

  #支援者専用ページ
  def supporter_only
    unless current_user.user_type == 1
			head :not_found
    end
  end

  #ライブハウス専用ページ
  def livehouse_only
    unless current_user.user_type == 3
			head :not_found
    end
  end

	#レビュー
  def set_review_scores(reviews)
    unless reviews.blank?
      @total_review = reviews.average(:total_review).round(2)
      @total_quality = reviews.average(:quality).round(2)
      @total_confortability = reviews.average(:confortability).round(2)
      @total_cost_performance = reviews.average(:cost_performance).round(2)
      @total_manners = reviews.average(:manners).round(2)
      @total_fast_response = reviews.average(:fast_response).round(2)
    end
  end


#支払期限(見積り承認1週間後か本番の銀行2営業日前のうち、早い方の15時まで)
  def payment_due(t1, t2)
    time1 = t1 + 7.days #見積り承認1週間後
    time2 = 2.business_days.before(t2) #本番3営業日前
    return  [time1, time2].min.beginning_of_day + 15.hours
  end

private

  # 二段階認証を設定後リダイレクト先がルートになった問題を修正
  # https://github.com/heartcombo/devise/wiki/How-To:-Redirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr? && request.fullpath != root_path
  end

	def store_user_location!
		store_location_for(:user, request.fullpath)
	end

end
