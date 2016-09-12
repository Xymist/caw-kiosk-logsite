class JurisdictionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_jurisdiction, only: [:show, :edit, :update, :destroy]

  before_action :check_for_cancel, only: [:create, :update]

  def check_for_cancel
    redirect_to jurisdictions_path if params[:commit] == 'Cancel'
  end

  def index
    @kiosks = Kiosk.all
    @unassigned_kiosks = []
    @kiosks.each do |kiosk|
      @unassigned_kiosks << kiosk if kiosk.jurisdiction.nil?
    end
    @jurisdictions = Jurisdiction.all
    @kiosk_topics = KioskTopic.all
    @pages = AdvicePage.all
    @newpage = AdvicePage.new
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @jurisdiction = Jurisdiction.new(jurisdiction_params)

    respond_to do |format|
      if @jurisdiction.save
        format.html { redirect_to @jurisdiction, notice: 'Jurisdiction was successfully created.' }
        format.json { render json: @jurisdiction, status: :created, location: @jurisdiction }
      else
        format.html { render :new }
        format.json { render json: @jurisdiction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @jurisdiction.update(jurisdiction_params)
        format.html { redirect_to @jurisdiction, notice: 'Jurisdiction was successfully updated.' }
        format.json { render json: @jurisdiction, status: :ok, location: @jurisdiction }
      else
        format.html { render :edit }
        format.json { render json: @jurisdiction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @jurisdiction.destroy
    respond_to do |format|
      format.html { redirect_to kiosk_admin_url, notice: 'Jurisdiction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_jurisdiction
    @jurisdiction = Jurisdiction.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def jurisdiction_params
    params.require(:jurisdiction).permit(:name, :telephone, :pbx_server, kiosk_topic_ids: [])
  end
end
