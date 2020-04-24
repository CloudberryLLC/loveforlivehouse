class Users::SessionsController < Devise::SessionsController
  prepend_before_action :authenticate_with_two_factor, only: [:create]

  private
  def authenticate_with_two_factor
    # strong parameters
    user_params = params.require(:user).permit(:email, :password, :remember_me, :otp_attempt)

    if user_params[:email]
      user = User.find_by(email: user_params[:email])

    elsif user_params[:otp_attempt].present? && session[:otp_user_id]
      user = User.find(session[:otp_user_id])
    end
    self.resource = user

    return unless user && user.otp_required_for_login

    if user_params[:email]
      if user.valid_password?(user_params[:password])
        session[:otp_user_id] = user.id
        render 'devise/sessions/two_factor' and return
      end

    elsif user_params[:otp_attempt].present? && session[:otp_user_id]
      if user.validate_and_consume_otp!(user_params[:otp_attempt])
        session.delete(:otp_user_id)
        sign_in(user)
        redirect_to dashboard_path(user), notice:"ログインしました"
        return
      else
        flash.now[:alert] = 'コードが違います'
        render :two_factor and return
      end
    end
  end
end
