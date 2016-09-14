class SendReportsEmailsJob < ApplicationJob
  queue_as :default

  def perform
    Kiosk.all.each do |kiosk|
      # If there have never been any visits recorded, skip that kiosk.
      next unless kiosk.visits.last
    end
  end
end
