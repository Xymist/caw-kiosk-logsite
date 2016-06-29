class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  def home
    @kiosks = Kiosk.all
    @allowed_kiosks = Kiosk.where(:jurisdiction => current_user.jurisdictions)
    @disallowed_kiosks = @kiosks - @allowed_kiosks
    @visits = Visit.where(:kiosk => @allowed_kiosks)
    @title = "Home"
    @feedback_hash = {}
    @kiosk_ids = []
    @allowed_kiosks.each do |kiosk| @kiosk_ids << kiosk.id end
    @feedback_hash["Feedback Responses"] = FormResponse.where(kiosk: @kiosk_ids).count
    @feedback_hash["Feedback Views"] = Visit.where(topic: Topic.find_by(location: "feedback"), kiosk: @kiosk_ids).count
  end

  def logs
    @hosts = Host.all
    @title = "Logs"
    @kiosks = Kiosk.all
    @allowed_kiosks = Kiosk.where(:jurisdiction => current_user.jurisdictions)
    @disallowed_kiosks = @kiosks - @allowed_kiosks
    @visits = Visit.where(:kiosk => @allowed_kiosks)
  end

  def status
    @kiosks = Kiosk.all
    @allowed_kiosks = Kiosk.where(:jurisdiction => current_user.jurisdictions)
    @disallowed_kiosks = @kiosks - @allowed_kiosks
    @title = "Kiosk Status"
  end

  def kiosk_log
    @kiosk = Kiosk.find_by(name: params[:kiosk])
    @hosts = Host.all
    @title = "Kiosk Data"
    @visits = Visit.where(kiosk: @kiosk)
    @topics = Topic.all
    @feedback_hash = {}
    @feedback_hash["Feedback Responses"] = @kiosk.form_responses.count
    @feedback_hash["Feedback Views"] = @kiosk.visits.where(topic: Topic.find_by(location: "feedback")).count
  end

  def vncpanel
    @title = "VNC Panel"
  end

end
