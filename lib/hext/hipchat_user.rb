require './lib/hext/hipchat_interface'

module HipExt
  class HipChatUser
    attr_reader :email, :hipchat_id, :mention_name, :name, :status

    def initialize(_data)
      @hipchat_id = _data['id']
      @email = _data['email']
      @mention_name = _data['mention_name']
      @name = _data['name']
      @status = _data['presence']['show'] rescue 'chat'
    end

    def self.get_users
      users = []
      HipExt::HipChatInterface.get_users.each do |user|
        users << HipExt::HipChatUser.new(user) unless user.nil?
      end
      users
    end

    def to_hash
      {
        id: self.hipchat_id,
        email: self.email,
        mention_name: self.mention_name,
        name: self.name
      }
    end

    def update_status _status_message
      data = self.to_hash

      data[:presence] = {
        status: _status_message,
        show: self.status
      }

      HipExt::HipChatInterface.update_user(
        self.hipchat_id, data)
    end
  end
end
