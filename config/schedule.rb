#every 5.minutes do
#  runner "PanicMailJob.perform_now()"
#end

every 24.hours do
  runner "DatabaseStufferJob.perform_now()"
end

set :output, "/log/cron_log.log"
