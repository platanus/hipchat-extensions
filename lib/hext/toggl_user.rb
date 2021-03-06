require './lib/hext/toggl_interface'

module HipExt
  class TogglUser
    attr_reader :toggle_id, :email, :fullname, :api_token

    def initialize(_data)
      @toggle_id = _data['id'].to_i
      @email = _data['email']
      @fullname = _data['fullname']
      @api_token = _data['api_token']
    end

    def self.get_user _email
      app_user = User.where(email: _email).where.not(toggl_api_token: nil).first
      return if app_user.nil? or app_user.toggl_api_token.nil?
      user_data = HipExt::TogglInterface.get_user(app_user.toggl_api_token)
      HipExt::TogglUser.new(user_data['data']) if !user_data.nil? and !user_data['data'].nil?
    end

    def current_activity
      time_entry = HipExt::TogglInterface.get_current_time_entry(self.api_token)
      msg = time_entry['data']['description'] rescue nil
      pid = time_entry['data']['pid'] rescue nil
      return '' if msg.nil? and pid.nil?
      return msg if pid.nil?
      project_data = HipExt::TogglInterface.get_project(pid, self.api_token)
      project_name = project_data['name'] rescue nil
      return "#{project_name} (#{msg})" if !project_name.nil? and !msg.nil?
      return msg if project_name.nil?
      project_name
    end

    private

      def self.included? _user_id, _users
        _users.each { |user| return true if _user_id.to_i == user.toggle_id }
        return false
      end
  end
end
