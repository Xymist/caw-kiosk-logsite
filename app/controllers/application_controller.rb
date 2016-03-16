class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def users
    user_count = {}
    last_time = Time.zone.parse('2016-01-01 00:00:01')

    Kiosk.all.each do |kiosk|
      user_count["#{kiosk.name}"] = 0
      visits = Visit.where(kiosk: kiosk).order("time_stamp")
      visits.each do |visit|
        if visit.time_stamp > last_time + 5.minutes
          user_count["#{kiosk.name}"] += 1
          last_time = visit.time_stamp
        end
      end
    end
    return user_count
  end

  def home
    @kiosks = Kiosk.all
    @users = users
  end

  def logs
    @hosts = Host.all
    @title = "Logs"
    @kiosks = Kiosk.all
    @visits = Visit.all
  end

  def status
    @kiosks = Kiosk.all
    @title = "Kiosk Status"
  end

  def heartbeat
    render :layout => false
    @kiosk = params[:kiosk]
  end

  def kiosk_log
    @kiosk = Kiosk.find(params[:id])
    @hosts = Host.all
    @title = "Kiosk Data"
    @visits = Visit.all
    @topics = Topic.all
    @users = users
  end

end
