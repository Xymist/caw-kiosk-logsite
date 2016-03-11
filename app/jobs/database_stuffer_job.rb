class DatabaseStufferJob < ApplicationJob
  queue_as :default

  def perform()
    require 'date'
    Dir.glob('app/assets/kiosk_logs/*.log').each do |logfile|
      logname = logfile.split("/")
      kiosk = logname[-1].split(".")
      access_data = IO.readlines(logfile)
      access_data.each do |data|
        split_data = data.split()
        time_stamp = split_data[0]
        hostname = split_data[1]
        topicname = split_data[2]
        host = Host.find_or_create_by(name: hostname)
        topic = host.topics.find_or_create_by(location: topicname)
        kiosk_name = Kiosk.find_or_create_by(name: kiosk[0])
        topic.visits.find_or_create_by(time_stamp: time_stamp, kiosk_id: kiosk_name.id)
      end
    end
  end
end
