ActiveAdmin.register User do
  permit_params :email, :name, :toggl_api_token

  filter :name
  filter :email
end
