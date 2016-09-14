class ReportMailer < ApplicationMailer
  require 'date'

  default from: 'kioskreports@logserver.3rdsectorit.co.uk'

  def report_email(kiosk)
    @kiosk = Kiosk.find_by(name: kiosk)

    month = Date.yesterday.strftime('%B')
    @month_visits = @kiosk.visits.where('visits.created_at >= ?', Date.yesterday.beginning_of_month)
    @hosts = Host.all
    @title = 'Kiosk Data'
    internal_hostnames = ['82.70.248.237', 'logserver.3rdsectorit.co.uk']
    @topic_visits = {}
    @month_visits.each do |visit|
      if (internal_hostnames.include? visit.host.name) || (visit.topic.location == 'landing_page')
        # Nothing. TODO: This really ought to be an 'unless'.
      else
        location = visit.topic.location
        if @topic_visits[location]
          @topic_visits[location] += 1
        else
          @topic_visits[location] = 1
        end
      end
    end
    @topics = Topic.all
    @feedback_hash = {}
    @feedback_hash['Feedback Responses'] = @kiosk.form_responses.count
    @feedback_hash['Feedback Views'] = @month_visits.where(topic: Topic.find_by(location: 'feedback')).count

    supervisor_email = @kiosk.jurisdiction.email

    @url = "http://logserver.3rdsectorit.co.uk/logs/#{kiosk}"

    mail(to: supervisor_email.to_s, subject: "#{kiosk.capitalize} Kiosk Usage Report for #{month}") do |format|
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
