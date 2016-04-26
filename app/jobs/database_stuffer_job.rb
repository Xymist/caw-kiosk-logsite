class DatabaseStufferJob < ApplicationJob
  queue_as :default
  require 'digest/md5'

  def perform()
    require 'date'
    Dir.glob('app/assets/kiosk_logs/*.log').each do |logfile|
      begin
      logname = logfile.split("/")
      rescue NoMethodError
      end
      @kiosk = logname[-1].split(".")
      @access_data = IO.readlines(logfile)
      @inserted_data = 0
      @access_data.each do |data|
        split_data = data.split('|')
        time_stamp = split_data[0]
        hostname = split_data[1]
        topicnames = split_data[2].split(',')
        host = Host.find_or_create_by(name: hostname)
        if host.name == "82.70.248.237" && topicnames.length > 2 # Only true for topic pages
          topic = host.topics.find_or_create_by(location: topicnames[2].chomp)
        elsif host.name == "82.70.248.237" # Only true for the homepage
          topic = host.topics.find_or_create_by(location: topicnames[1].chomp)
        else # Anything else is external
          topic = host.topics.find_or_create_by(location: topicnames[0].chomp)
        end
        kiosk_name = Kiosk.find_or_create_by(name: @kiosk[0])
        begin
        topic.visits.find_or_create_by(time_stamp: time_stamp, kiosk_id: kiosk_name.id, checksum: Digest::MD5.hexdigest("#{time_stamp}|#{kiosk_name}"))
        @inserted_data += 1
        rescue ActiveRecord::RecordNotUnique
        end

      end #do |data|
    end #do |logfile|
    LogEvent.create(log_caller: "Database Stuffer", event: "Performed insert of #{@inserted_data} records for #{@kiosk[0].capitalize}")
  end #perform
end #Class
