class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  #protect_from_forgery with: :exception

  before_filter :authenticate_user!, except: [:receive_log]

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
    @topics = Topic.all
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
    internal_hostnames = ["82.70.248.237", "logserver.3rdsectorit.co.uk"]
    @topic_visits = {}
    @kiosk.visits.each do |visit|
      if internal_hostnames.include? visit.host.name || visit.topic.location == "landing_page"
        # Nothing
      else
        location = visit.topic.location
        if @topic_visits[location]
          @topic_visits[location] += 1
        else
          @topic_visits[location] = 1
        end
      end
    end
    @topics = Topic.all
    @feedback_hash = {}
    @feedback_hash["Feedback Responses"] = @kiosk.form_responses.count
    @feedback_hash["Feedback Views"] = @kiosk.visits.where(topic: Topic.find_by(location: "feedback")).count
  end

  def receive_log
    head :ok
    @url_array = []
    AdvicePage.all.each do |page| # Do I really want to build this every time we receive a click?!
      @url_array << "#{page.url}"
    end
    @kiosk = Kiosk.find_or_create_by(name: params[:kiosk])
    @url = params[:url]
    @unix_timestamp = params[:timestamp]
    @kiosk.ip_address = params[:kiosk_ip]
    @kiosk.save # This updates the ip_address field, BEFORE we check whether the
    # visit is to one of the internal links. That ensures that the VPN IP is
    # always kept up to date.
    @hostname = @url.sub(/^https?\:\/\/(www.)?/,'').split('/')[0]
    @topicpath = @url.sub(/^https?\:\/\/(www.)?/,'').sub(@hostname + '/','')
    @host = Host.find_or_create_by(name: @hostname)
    @topic = @host.topics.find_or_create_by(location: @topicpath)

    unless @url_array.include? @url or @hostname.include? "logserver" # These should be taken care of when the user makes the clicks.
      begin
        @visit = @topic.visits.find_or_create_by(time_stamp: Time.at(@unix_timestamp), kiosk_id: @kiosk.id, checksum: Digest::MD5.hexdigest("#{@unix_timestamp}|#{@kiosk.name}"))
      rescue ActiveRecord::RecordNotUnique
      end #begin
    end
  end

  def vncpanel
    @title = "VNC Panel"
  end

end
