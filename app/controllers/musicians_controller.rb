class MusiciansController < ApplicationController

  before_action :set_record

  def index
  end

  def show
  	unless @user.user_type == "3"
  		redirect_to root_path, notice:"該当の演奏家は見つかりませんでした"
  	end
  end

private

	def set_record
	  @user = User.find(params[:id])
	end

end
