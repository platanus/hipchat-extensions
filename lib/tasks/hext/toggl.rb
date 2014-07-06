require './lib/hext/hipchat_user'
require 'faker'

module HipExt
  class Toggl
    def self.update_users_status
      HipExt::HipChatUser.get_users.each do |hc_user|
        hc_user.update_status(::Faker::Name.name)
      end
    end
  end
end
