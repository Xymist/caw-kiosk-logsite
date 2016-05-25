class FeedbackController < ApplicationController

  def overview
    @kiosks = Kiosk.all
    @jurisdictions = Jurisdiction.all
    @form_responses = FormResponse.all
  end

  def kiosk
    @kiosk = Kiosk.find_by(name: params[:kiosk])
    @form_responses = FormResponse.where(kiosk: @kiosk.id)
  end

end
