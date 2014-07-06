# -*- coding: utf-8 -*-
namespace :app do
  namespace :toggl do
    require 'tasks/hext/toggl.rb'

    desc "Check occupation based on toggl timer and updates users hipchat status with that information"
    task :update_users_statuses => :environment do
      HipExt::Toggl.update_users_statuses
    end
  end
end
