class PublicKioskController < ApplicationController
  def home
    @kiosk_id = params[:id]
    @kiosk_topics = KioskTopic.all
  end

  def advice_topic
    @kiosk_id = params[:id]
    @topic = params[:topic]
    @advice_pages = AdvicePage.where(topic: params[:topic].to_s)
  end
end
