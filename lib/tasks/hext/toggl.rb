require './lib/hext/hipchat_user'
require './lib/hext/toggl_user'
require 'faker'

module HipExt
  class Toggl
    def self.update_users_statuses
      hc_users = HipExt::HipChatUser.get_users.each

      User.all.each do |app_user|
        toggle_user = HipExt::TogglUser.get_user(app_user.email)
        current_activity = toggle_user.current_activity
        update_hipchat_status(app_user.email, current_activity, hc_users) unless current_activity.nil?
      end
    end

    private

      def self.update_hipchat_status _email, _msg, _hipchat_users
        return if _hipchat_users.nil?
        _hipchat_users.each do |hc_user|
          hc_user.update_status(_msg) if hc_user.email == _email
        end
      end
  end
end
