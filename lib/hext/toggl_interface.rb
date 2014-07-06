require 'httparty'

module HipExt
  class TogglInterface

    def self.get_user _toggl_api_token
      do_get('me', _toggl_api_token)
    end

    def self.get_current_time_entry _toggl_api_token
      do_get('time_entries/current', _toggl_api_token)
    end

    def self.get_project _pid, _toggl_api_token
      workspaces = do_get("workspaces", _toggl_api_token)
      return if workspaces.nil?
      projects = []
      workspaces.each do |ws|
        ws_projects = do_get("workspaces/#{ws['id']}/projects", _toggl_api_token)
        projects += ws_projects unless ws_projects.nil?
      end

      projects.each do |project|
        return project if project['id'].to_i == _pid.to_i
      end
    end

    private
      def self.credentials _toggl_api_token
        {username: _toggl_api_token, password: "api_token"}
      end

      def self.do_get _action, _toggl_api_token
        result = ::HTTParty.get api_url(_action), :basic_auth => credentials(_toggl_api_token)
        get_response(result, 200)
      end

      def self.get_response _result, _code
        _code = _code.to_i
        return nil unless _result.response.code.to_i == _code
        _result.parsed_response
      end

      def self.api_url _action
        "#{ENV['TOGGL_API_URL']}/#{_action}"
      end
  end
end
