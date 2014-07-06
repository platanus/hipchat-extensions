class User < ActiveRecord::Base
  validates_presence_of :email, :name, :toggl_api_token
end
