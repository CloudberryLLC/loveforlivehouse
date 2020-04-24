class HelpsController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index, :search]
  before_action :admin_only, except: [:show, :index, :search]
  before_action :set_help, only: [:show, :edit, :update, :destroy]

  # GET /helps
  # GET /helps.json
  def index
    unless params[:category].present?
      @category = nil
      @helps = Help.all.page(params[:page]).per(10)
    else
      @category = params[:category]
      @helps = Help.where(category: @category).page(params[:page]).per(10)
    end
  end

  # GET /helps/1
  # GET /helps/1.json
  def show
  end

  # GET /helps/new
  def new
    @help = Help.new
  end

  # GET /helps/1/edit
  def edit
  end

  # POST /helps
  # POST /helps.json
  def create
    @help = Help.new(help_params)

    respond_to do |format|
      if @help.save
        format.html { redirect_to @help, notice: 'Help was successfully created.' }
        format.json { render :show, status: :created, location: @help }
      else
        format.html { render :new }
        format.json { render json: @help.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /helps/1
  # PATCH/PUT /helps/1.json
  def update
    respond_to do |format|
      if @help.update(help_params)
        format.html { redirect_to @help, notice: 'Help was successfully updated.' }
        format.json { render :index, status: :ok, location: @help }
      else
        format.html { render :edit }
        format.json { render json: @help.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /helps/1
  # DELETE /helps/1.json
  def destroy
    @help.destroy
    respond_to do |format|
      format.html { redirect_to helps_url, notice: 'Help was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def uploadFileAttachment
    @help.save!
  end

  def article_search

  end

#  def deleteFileAttachment
#   https://railsguides.jp/active_storage_overview.html#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%92%E5%89%8A%E9%99%A4%E3%81%99%E3%82%8B
#  end
	#ヘルプ検索
  def search
    keyword_search
    render json: @helps
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_help
      @help = Help.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def help_params
      params.require(:help).permit(:title, :category, :content, screenshots:[])
    end

    def keyword_search
      params.permit(:keyword)
      keyword = params[:keyword]
      @helps = Help.where(['title LIKE?', "%#{keyword}%"])
    end

end
