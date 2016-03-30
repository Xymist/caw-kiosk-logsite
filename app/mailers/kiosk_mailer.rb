class KioskMailer < ApplicationMailer
  default from: 'kioskstatus@3rdsectorit.co.uk'
  def panic_email(kiosk)
    @kiosk = kiosk
    @url  = 'http://82.70.248.237/status'
    mail(to: 'alok@3rdsectorit.co.uk', subject: "#{@kiosk.capitalize} kiosk is disconnected")
  end
end
