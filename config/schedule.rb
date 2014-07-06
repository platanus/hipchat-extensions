every 2.minutes do
  rake "hext:toggl:update_users_statuses", :environment => :production
end
