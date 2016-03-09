class DatabaseStufferJob < ApplicationJob
  queue_as :default

  def perform()
    Dir.glob('app/assets/kiosk_logs/*.log').each do |logfile|
      logname = logfile.split("/")
      kiosk = logname[3].split(".")
      access_data = IO.readlines(logfile)
      access_data.each do |data|
        split_data = data.split()
        time_stamp = split_data[0]
        hostname = split_data[1]
        topicname = split_data[2]
        host = Host.find_or_create_by(name: hostname)
        topic = host.topics.find_or_create_by(location: topicname)
        topic.visits.create(time_stamp: time_stamp, kiosk: kiosk[0])
      end
    end
  end
end
