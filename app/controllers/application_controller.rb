class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def home

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
  end

end
