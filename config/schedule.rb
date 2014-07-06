set :job_template, "bash -lc ':job'"
set :output, "log/cron.log"

every 2.minutes do
  rake "hext:toggl:update_users_status", :environment => :production
end
