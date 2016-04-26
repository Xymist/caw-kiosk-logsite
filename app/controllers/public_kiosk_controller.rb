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

  def exit_site
    new_url = params[:exit_url].sub(/^https?\:\/\/(www.)?/,'').split('/')
    new_host = new_url[0]
    new_topic = new_url[1]
    host = Host.find_or_create_by(name: new_host)
    topic = host.topics.find_or_create_by(location: new_topic.chomp)
    kiosk = Kiosk.find_or_create_by(name: params[:kiosk])
    begin
      topic.visits.find_or_create_by(time_stamp: time_stamp, kiosk_id: kiosk.id, checksum: Digest::MD5.hexdigest("#{time_stamp}|#{kiosk_name}"))
    rescue ActiveRecord::RecordNotUnique
    end
    redirect_to params[:exit_url]
  end

end
