# -*- coding: utf-8 -*-
namespace :hext do
  namespace :toggl do
    require 'tasks/hext/toggl.rb'

    desc "Check occupation based on toggl timer and updates users hipchat status with that information"
    task :update_users_status => :environment do
      HipExt::Toggl.update_users_status
    end
  end
end
