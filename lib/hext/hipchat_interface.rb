require 'httparty'

module HipExt
  class HipChatInterface

    def self.get_users
      users = do_get('user')
      return if !users or !users.has_key? 'items'
      users['items'].inject([]) do |detailed_users, user|
        u = get_user(user['id'])
        puts u.inspect
        detailed_users << u unless u.nil?
      end
    end

    def self.get_user _user_id
      do_get("user/#{_user_id}")
    end

    def self.update_user _user_id, _data
      return unless _user_id
      do_put("user/#{_user_id}", _data)
    end

    private

      def self.do_put _action, _params
        result = ::HTTParty.put(api_url(_action),
          headers: {'Content-Type' => 'application/json'},
          body: _params.to_json)

        get_response(result, 204)
      end

      def self.do_get _action
        result = ::HTTParty.get api_url(_action)
        get_response(result, 200)
      end

      def self.get_response _result, _code
        _code = _code.to_i
        return nil unless _result.response.code.to_i == _code
        _result.parsed_response
      end

      def self.api_url _action
        "#{ENV['HIPCHAT_API_URL']}/#{_action}?auth_token=#{ENV['HIPCHAT_AUTH_TOKEN']}"
      end
  end
end
