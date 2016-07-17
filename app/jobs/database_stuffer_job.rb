class DatabaseStufferJob < ApplicationJob


  queue_as :default
  require 'digest/md5'

  def perform()
    require 'date'

    @url_array = []
    AdvicePage.all.each do |page|
      @url_array << "#{page.url}"
    end

    Dir.glob('app/assets/kiosk_logs/*.log').each do |logfile|
      begin
      logname = logfile.split("/")
      rescue NoMethodError
      end #begin

      @kiosk = logname[-1].split(".")
      @access_data = IO.readlines(logfile)
      @inserted_data = 0
      @url_hash = {}

      @access_data.each do |data|
        split_data = data.split("|")
        hostname = split_data[1].sub(/^https?\:\/\/(www.)?/,'').split('/')[0]
        unless hostname == "82.70.248.237" or @url_array.include? split_data[1] or hostname.include? "logserver"
          @url_hash[split_data[0]] = split_data[1] #Time stamp = address
        end # unless hostname
      end #do |data|

      @url_hash.each do |time_stamp, full_url|
        split_url = full_url.sub(/^https?\:\/\/(www.)?/,'').split('/')
        hostname = split_url[0]
        topicpath = full_url.sub(/^https?\:\/\/(www.)?/,'').sub(hostname + '/','')
        host = Host.find_or_create_by(name: hostname)
        topic = host.topics.find_or_create_by(location: topicpath)
        kiosk_name = Kiosk.find_or_create_by(name: @kiosk[0])
          begin
            topic.visits.find_or_create_by(time_stamp: Time.at(time_stamp.to_i), kiosk_id: kiosk_name.id, checksum: Digest::MD5.hexdigest("#{time_stamp}|#{kiosk_name}"))
            @inserted_data += 1
          rescue ActiveRecord::RecordNotUnique
          end #begin
        end # do |time, url|
      end #do |logfile|
    LogEvent.create(log_caller: "Database Stuffer", event: "Performed insert of #{@inserted_data} records for #{@kiosk[0].capitalize}", type: "#{@kiosk[0]} record insertion")
  end #perform
end #Class
