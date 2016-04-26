class PublicKioskController < ActionController::Base
  def home
    @kiosk_topics = KioskTopic.all
    @kiosk = Kiosk.find_by(name: params[:kiosk])
  end

  def advice_topic
    @kiosk = Kiosk.find_by(name: params[:kiosk])
    @topic = params[:topic]
    @advice_pages = AdvicePage.where(topic: params[:topic].to_s)
  end

  def heartbeat
    render :layout => false
    @kiosk = params[:kiosk]
  end

  def exit_site
    @kiosk = Kiosk.find_by(name: params[:kiosk])
    @topic = params[:topic]
    @hostname = params[:exit_url].split(".")[1]
    time_stamp = Time.now
    kiosk_name = @kiosk.name
    Visit.create(time_stamp: time_stamp, topic_id: Topic.find_or_create_by(location: @topic, host: Host.find_or_create_by(name: @hostname)).id, kiosk_id: @kiosk.id, checksum: Digest::MD5.hexdigest("#{time_stamp}|#{kiosk_name}"))
    redirect_to params[:exit_url]
  end

end
