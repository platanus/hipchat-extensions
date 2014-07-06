ActiveAdmin.register User do
  permit_params :email, :name

  filter :name
  filter :email
end
