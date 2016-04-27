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
    new_url = AdvicePage.find_by(id: params[:exit_url_id]).url
    split_url = new_url.sub(/^https?\:\/\/(www.)?/,'').split('/')
    new_host = split_url[0]
    new_topic = split_url[1]
    time_stamp = Time.now
    host = Host.find_or_create_by(name: new_host)
    topic = new_topic ? host.topics.find_or_create_by(location: new_topic.chomp) : Topic.find_or_create_by(location: params[:topic], host: host)
    kiosk = Kiosk.find_or_create_by(name: params[:kiosk])
    begin
      topic.visits.find_or_create_by(time_stamp: time_stamp, kiosk_id: kiosk.id, checksum: Digest::MD5.hexdigest("#{time_stamp}|#{kiosk.name}"))
    rescue ActiveRecord::RecordNotUnique
      # find_or_create_by should obviate this, but it's still here because things break otherwise.
    end
    redirect_to new_url
  end

end
