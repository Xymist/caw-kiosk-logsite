class PublicKioskController < ActionController::Base

  before_filter :set_cache_headers
  before_action :set_form_response, only: [:show, :edit, :update, :destroy]

  def home
    @kiosk_topics = KioskTopic.all
    @kiosk = Kiosk.find_by(name: params[:kiosk])
    @jurisdiction = @kiosk.jurisdiction
  end

  def advice_topic
    @kiosk = Kiosk.find_by(name: params[:kiosk])
    @topic = params[:topic]
    @jurisdiction = @kiosk.jurisdiction
    @advice_pages = AdvicePage.where(topic: params[:topic].to_s)
  end

  def heartbeat
    render :layout => false
    @kiosk = params[:kiosk]
  end

  def landing_page
    @kiosk = Kiosk.find_by(name: params[:kiosk])
    @jurisdiction = @kiosk.jurisdiction
  end

  def exit_site
    new_url = AdvicePage.find_by(id: params[:exit_url_id]).url
    split_url = new_url.sub(/^https?\:\/\/(www.)?/,'').split('/')
    new_host = split_url[0]
    new_topic = split_url[1]
    time_stamp = Time.now
    host = Host.find_or_create_by(name: new_host)
    topic = new_topic ? host.topics.find_or_create_by(location: new_topic.chomp) : Topic.find_or_create_by(location: params[:topic], host: host)
    kiosk = Kiosk.find_by(name: params[:kiosk])
    begin
      topic.visits.find_or_create_by(time_stamp: time_stamp, kiosk_id: kiosk.id, checksum: Digest::MD5.hexdigest("#{time_stamp}|#{kiosk.name}"))
    rescue ActiveRecord::RecordNotUnique
      # TODO: find_or_create_by should obviate this, but it's still here because things break otherwise. I do not know why.
    end
    redirect_to new_url
  end

  def feedback
    @form_response = FormResponse.new
    @kiosk = Kiosk.find_by(name: params[:kiosk])
    @jurisdiction = @kiosk.jurisdiction

    @disability_options = ["I am disabled", "Long-term health condition","Not disabled/no known health problems","Unknown/Decline to answer"]
    @sex_options        = ["Male", "Female","Both","Neither","Trans: M->F","Trans: F->M","Other", "Unknown/Decline to answer"]
    @carer_options      = ["In Care", "Paid Carer", "Unpaid Carer", "None of the above", "Unknown/Decline to answer"]
    @gp_visits_options  = ["0","1-4", "5-9", "10-24", "25+"]
    @income_options     = ["<£400","£400-599", "£600-799", "£800-999", "£1000-1499", "£1500-1999", "£2000-2999", "£3000+"]
    @kiosk_topics       = []
    KioskTopic.all.each do |topic|
      @kiosk_topics << topic.name.capitalize
    end
    @referral_options   = ["Referred by doctor", "Referred by nearby staff", "Just passing by", "Word of mouth", "Poster or flyer"]
    @feedback_options   = ["1 - Entirely Useless","2 - Mostly Useless","3 - Somewhat Helpful","4 - Very Helpful","5 - Extremely Helpful"]
  end

  def create_feedback
    @current_kiosk = params[:kiosk]
    @form_response = FormResponse.new(form_response_params)

    respond_to do |format|
      if @form_response.save
        format.html { redirect_to "/public_kiosk/#{@current_kiosk}", notice: 'Feedback submitted. Thank you!' }
        format.json { render json: @form_response, status: :created, location: @form_response}
      else
        format.html { redirect_to :back, alert: 'There was a problem; your feedback was not saved.' }
        format.json { render json: @form_response.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

  end

  def destroy

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_response
      @form_response = FormResponse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_response_params
      params.require(:form_response).permit(:year,:disability,:sex,:income,:carer,:gp_visits,:hospital_time,:problem_type,:referral_type,:telephone_usage,:feedback, :kiosk_id)
    end

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
