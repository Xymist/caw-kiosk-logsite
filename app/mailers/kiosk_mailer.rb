class KioskMailer < ApplicationMailer
  default from: 'kioskstatus@caw-kiosk-logsite.co.uk'
  def panic_email(kiosk)
    @kiosk = kiosk
    @url  = 'http://82.70.248.237/status'
    mail(to: 'jamie.f.duerden@gmail.com', subject: "#{@kiosk.capitalize} is disconnected")
  end
end
