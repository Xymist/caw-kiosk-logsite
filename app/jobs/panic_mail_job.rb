class PanicMailJob < ApplicationJob
  queue_as :default

  def perform
    Kiosk.all.each do |kiosk|
      next unless kiosk.heartbeats.last # If the kiosk has ever made contact....
      if kiosk.heartbeats.last.created_at < 15.minutes.ago        # But the last contact was over 15 minutes ago...
        if kiosk.notified != true                                 # If nobody has been told about it
          KioskMailer.panic_email(kiosk.name.to_s).deliver_now # Send an email
          kiosk.notified = true
          kiosk.save                                              # Set the flag so we don't send hundreds of emails.
        end
      else                                                        # If the kiosk has been in contact more recently than 15 minutes ago...
        kiosk.notified = false
        kiosk.save                                                # Reset; either there has never been a problem or the problem has been solved.
      end
    end
  end
end
