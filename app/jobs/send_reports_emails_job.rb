class SendReportsEmailsJob < ApplicationJob
  queue_as :default

  def perform
    Kiosk.all.each do |kiosk|
      # If there have never been any visits recorded, or if there is no relevant
      # email address to use, skip that kiosk.
      next if !kiosk.visits.last || !kiosk.jurisdiction.email
      ReportMailer.report_email(kiosk.name.to_s).deliver_now
    end
  end
end
