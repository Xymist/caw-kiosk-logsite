class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def home

  end

  def logs
    @hosts = Host.all
    @title = "Logs"
  end

  def status
    @kiosks = Kiosk.all
    @title = "Kiosk Status"
  end

  def heartbeat
    @kiosk = params[:kiosk]
  end

end
