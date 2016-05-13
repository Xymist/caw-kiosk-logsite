class KiosksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_kiosk, only: [:show, :edit, :update, :destroy]

  before_filter :check_for_cancel, :only => [:create, :update]

  def check_for_cancel
    if params[:commit] == "Cancel"
      redirect_to kiosks_path
    end
  end

  def index
    @kiosks = Kiosk.all
    @kiosk_topics = KioskTopic.all
    @pages = AdvicePage.all
    @newpage = AdvicePage.new
    @jurisdictions = Jurisdiction.all
  end

  def show

  end

  def new

  end

  def edit
  end

  def create
    @kiosk = Kiosk.new(kiosk_params)
    @jurisdictions = Jurisdiction.all

    respond_to do |format|
      if @kiosk.save
        format.html { redirect_to @kiosk, notice: 'Kiosk was successfully created.' }
        format.json { render json: @kiosk, status: :created, location: @kiosk }
      else
        format.html { render :new }
        format.json { render json: @kiosk.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @kiosk.update(kiosk_params)
        format.html { redirect_to @kiosk, notice: 'Kiosk was successfully updated.' }
        format.json { render json: @kiosk, status: :ok, location: @kiosk }
      else
        format.html { render :edit }
        format.json { render json: @kiosk.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @kiosk.destroy
    respond_to do |format|
      format.html { redirect_to kiosk_admin_url, notice: 'Kiosk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kiosk
      @kiosk = Kiosk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kiosk_params
      params.require(:kiosk).permit(:name, :address, :contact, :notified, :jurisdiction_id)
    end
end
