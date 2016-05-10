class KioskAdminController < ApplicationController
  before_action :authenticate_user!
  before_action :set_jurisdiction, only: [:show, :edit, :update, :destroy]

  before_filter :check_for_cancel, :only => [:create, :update]

  def check_for_cancel
    if params[:commit] == "Cancel"
      redirect_to kiosk_admin_path
    end
  end

  def index
    @kiosks = Kiosk.all
    @allowed_kiosks = Kiosk.where(:jurisdiction => current_user.jurisdictions)
    @disallowed_kiosks = @kiosks - @allowed_kiosks
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
      params.require(:jurisdiction).permit(:name, :telephone, :pbx_server)
    end
end
