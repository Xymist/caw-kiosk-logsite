class DatabaseStufferJob < ApplicationJob
  queue_as :default
  require 'digest/md5'

  def perform
    require 'date'
    errors = []

    @url_array = []
    AdvicePage.all.each do |page|
      @url_array << page.url.to_s
    end

    Dir.glob('app/assets/kiosk_logs/*.log').each do |logfile|
      begin
        logname = logfile.split('/')
      rescue NoMethodError => nme
        errors << nme.message
      end # begin

      @kiosk = logname[-1].split('.')
      @access_data = IO.readlines(logfile)
      @inserted_data = 0

      @created_hash = create_url_hash(access_data)

      @created_hash.each do |time, url|
        insert_record(time, url)
      end # do |time, url|
    end # do |logfile|
    LogEvent.create(log_caller: 'Database Stuffer', event: "Performed insert of #{@inserted_data} records for #{@kiosk[0].capitalize}", type: "#{@kiosk[0]} record insertion")
  end # perform

  def create_url_hash(access_data)
    url_hash = {}

    access_data.each do |data|
      split_data = data.split('|')
      hostname = split_data[1].sub(/^https?\:\/\/(www.)?/, '').split('/')[0]
      unless hostname == '82.70.248.237' || @url_array.include?(split_data[1]) || hostname.include?('logserver')
        @url_hash[split_data[0]] = split_data[1] # Time stamp = address
      end # unless hostname
    end # do |data|

    url_hash
  end # create_url_hash

  def insert_record(time_stamp, full_url)
    split_url = full_url.sub(/^https?\:\/\/(www.)?/, '').split('/')
    hostname = split_url[0]
    topicpath = full_url.sub(/^https?\:\/\/(www.)?/, '').sub(hostname + '/', '')
    host = Host.find_or_create_by(name: hostname)
    topic = host.topics.find_or_create_by(location: topicpath)
    kiosk_name = Kiosk.find_or_create_by(name: @kiosk[0])
    begin
      topic.visits.find_or_create_by(time_stamp: Time.at(time_stamp.to_i), kiosk_id: kiosk_name.id, checksum: Digest::MD5.hexdigest("#{time_stamp}|#{kiosk_name}"))
      @inserted_data += 1
    rescue ActiveRecord::RecordNotUnique => nu
      errors << nu.message
    end # begin
  end
end # Class
