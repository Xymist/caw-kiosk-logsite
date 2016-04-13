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
      kiosk = logname[-1].split(".")
      access_data = IO.readlines(logfile)
      access_data.each do |data|
        split_data = data.split('|')
        time_stamp = split_data[0]
        hostname = split_data[1]
        topicnames = split_data[2].split(',')
        host = Host.find_or_create_by(name: hostname)
        topic = host.topics.find_or_create_by(location: topicnames[0].chomp)
        kiosk_name = Kiosk.find_or_create_by(name: kiosk[0])
        begin
        topic.visits.find_or_create_by(time_stamp: time_stamp, kiosk_id: kiosk_name.id, checksum: Digest::MD5.hexdigest("#{time_stamp}|#{kiosk_name}"))
        rescue ActiveRecord::RecordNotUnique
        end
      end
    end
  end
end
