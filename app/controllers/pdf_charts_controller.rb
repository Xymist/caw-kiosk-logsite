class PdfChartsController < ApplicationController
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

  def kiosk_topic_access_frequency
    topic_array = {}
    @topics.each do |topic|
      if topic.location != 'Feedback' && ['82.70.248.237', 'logserver.3rdsectorit.co.uk'].include?(topic.host.name)
        topic_array[topic.location.split('_')[0].capitalize.to_s] = @month_visits.where(topic: topic).count
      end
    end

    render json: topic_array.except('Home').chart_json
  end

  def external_page_access_frequency
    render json: @topic_visits.except('home', 'landing_page').chart_json
  end

  def external_visits_by_organisation
    visit_array = {}
    @hosts.each do |host|
      if host.name != 'logserver.3rdsectorit.co.uk'
        visit_array[host.name] = @month_visits.joins(:topic).where(topics: { host_id: host.id }).count
      end
    end
    render json: visit_array.chart_json
  end

  def all_clicks_by_hour_of_day
    render json: @month_visits.group_by_hour_of_day(:time_stamp).count.chart_json
  end

  def pageview_history_by_day
    render json: @month_visits.group_by_day(:time_stamp, format: '%B %d, %Y').count.chart_json
  end

  def pageview_history_by_week
    render json: @month_visits.group_by_week(:time_stamp, format: 'Week %U, %Y').count.chart_json
  end

  def pageview_history_cumulative
    sum = 0
    render json: @month_visits.group_by_day(:time_stamp).count.to_a.sort { |x, y| x[0] <=> y[0] }.map { |x, y| { x => (sum += y) } }.reduce({}, :merge).chart_json
  end

  def Feedback
    render json:  @feedback_hash.chart_json
  end
end
