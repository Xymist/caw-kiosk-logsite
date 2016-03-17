class KioskMailer < ApplicationMailer
  default from: 'kioskstatus@3rdsectorit.co.uk'
  def panic_email(kiosk)
    @kiosk = kiosk
    @url  = 'http://82.70.248.237/status'
    mail(to: '98d7fbf0@opayq.com', subject: "#{@kiosk} is disconnected")
  end
end
