every 2.minutes do
  rake "hext:toggl:update_users_status", :environment => :production
end
