every 20.minutes do
  runner "DatabaseStufferJob.perform_now()"
end

set :output, "/home/caw/apps/caw-kiosk-logsite/log/cron_log.log"
