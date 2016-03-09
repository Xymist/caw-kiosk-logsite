class DatabaseStufferJob < ApplicationJob
  queue_as :default

  def perform()
    log_files = Dir['../assets/kiosk_logs/*']

    log_files.each do |logfile|
      access_data = IO.readlines(logfile)
      access_data.each do |data|
        time_stamp = data[0]
        hostname = data[1]
        topicname = data[2]
        host = Host.find_or_create_by(name: hostname)
        topic = host.topics.find_or_create_by(location: topicname)
        topic.visits.create(time_stamp: time_stamp)
      end
    end
    DatabaseStufferJob.set(wait: 24.hours).perform_later() # Sets the job to run again a day later
  end
end
