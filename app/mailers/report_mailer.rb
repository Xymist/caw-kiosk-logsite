class ReportMailer < ApplicationMailer
  require 'date'

  default from: 'kioskreports@logserver.3rdsectorit.co.uk'

  def report_email(kiosk)
    @kiosk = Kiosk.find_by(name: kiosk)

    month = Date.yesterday.strftime('%B')
    supervisor_email = @kiosk.jurisdiction.email

    @url = "http://logserver.3rdsectorit.co.uk/logs/#{kiosk}"

    mail(to: supervisor_email.to_s, subject: "#{kiosk.capitalize} Kiosk Usage Report for #{month}") do |format|
      format.html
      format.text
      format.pdf do
        attachments["Kiosk_Usage_#{kiosk}_#{month}.pdf"] = WickedPdf.new.pdf_from_string(
          render_to_string(pdf: "Kiosk_Usage_#{kiosk}_#{month}",
                           template: 'application/kiosk_log.pdf.erb',
                           layout: 'kiosk_log_pdf.html.erb')
        )
      end
    end
  end
end
