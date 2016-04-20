class PublicKioskController < ApplicationController
  def home
    @kiosk_topics = KioskTopic.all
    @kiosk = Kiosk.find_by(name: params[:kiosk])
  end

  def advice_topic
    @kiosk = Kiosk.find_by(name: params[:kiosk])
    @topic = params[:topic]
    @advice_pages = AdvicePage.where(topic: params[:topic].to_s)
  end

end
