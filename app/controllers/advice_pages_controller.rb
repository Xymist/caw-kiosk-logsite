class AdvicePagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_advice_page, only: [:show, :edit, :update, :destroy]

  before_filter :check_for_cancel, :only => [:create, :update]

  def check_for_cancel
    if params[:commit] == "Cancel"
      redirect_to advice_pages_path
    end
  end

  # GET /advice_pages
  # GET /advice_pages.json
  def index
    @kiosks = Kiosk.all
    @allowed_kiosks = Kiosk.where(:jurisdiction => current_user.jurisdictions)
    @disallowed_kiosks = @kiosks - @allowed_kiosks
    @kiosk_topics = KioskTopic.all
    @pages = AdvicePage.all
    @newpage = AdvicePage.new
  end

  # GET /advice_pages/1
  # GET /advice_pages/1.json
  def show

  end

  # GET /advice_pages/new
  def new

  end

  # GET /advice_pages/1/edit
  def edit
  end

  # POST /advice_pages
  # POST /advice_pages.json
  def create
    @advice_page = AdvicePage.new(advice_page_params)

    respond_to do |format|
      if @advice_page.save
        format.html { redirect_to @advice_page, notice: 'Advice page was successfully created.' }
        format.json { render json: @advice_page, status: :created, location: @advice_page }
      else
        format.html { render :new }
        format.json { render json: @advice_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /advice_pages/1
  # PATCH/PUT /advice_pages/1.json
  def update
    respond_to do |format|
      if @advice_page.update(advice_page_params)
        format.html { redirect_to @advice_page, notice: 'Advice page was successfully updated.' }
        format.json { render json: @advice_page, status: :ok, location: @advice_page }
      else
        format.html { render :edit }
        format.json { render json: @advice_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advice_pages/1
  # DELETE /advice_pages/1.json
  def destroy
    @advice_page.destroy
    respond_to do |format|
      format.html { redirect_to advice_pages_url, notice: 'Advice page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advice_page
      @advice_page = AdvicePage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advice_page_params
      params.require(:advice_page).permit(:organisation, :url, :telephone, :topic, :kiosk_ids => [])
    end
end
