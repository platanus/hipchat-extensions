class AddTogglApiTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :toggl_api_token, :string
  end
end
