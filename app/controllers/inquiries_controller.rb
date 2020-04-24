class InquiriesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :admin_only, only: [:index]
  before_action :set_inquiry, only: [:show]

  # GET /inquiries
  # GET /inquiries.json
  def index
    @inquiries = Inquiry.all
  end

  # GET /inquiries/1
  # GET /inquiries/1.json
  def show
  end

  # GET /inquiries/new
  def new
    @inquiry = Inquiry.new
    if user_signed_in?
      @user ||= current_user
      @inquiry.name ||= current_user.basic.lastname + " " + current_user.basic.firstname rescue nil
      @inquiry.email ||= current_user.email
    end
  end

  # POST /inquiries
  # POST /inquiries.json
  def create
    @inquiry = Inquiry.new(inquiry_params)

    respond_to do |format|
      if @inquiry.save
        InquiryMailer.with(inquiry: @inquiry).new_inquiry.deliver_later
        InquiryMailer.with(inquiry: @inquiry).inquiry_sent_successfly.deliver_later
        format.html { redirect_to @inquiry, notice: '以下の内容でお問い合わせを受け付けました。' }
        format.json { render :show, status: :created, location: @inquiry }
      else
        format.html { render :new }
        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inquiry
      @inquiry = Inquiry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def inquiry_params
      params.require(:inquiry).permit(:name, :email, :category, :content, :closed)
    end
end
