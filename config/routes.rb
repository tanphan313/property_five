Rails.application.routes.draw do
  namespace :admin do
    mount_devise_token_auth_for "Admin", at: "admin_auth",
      skip: [:invitations],
      controllers: {sessions: "admin/sessions"}
  end
end
