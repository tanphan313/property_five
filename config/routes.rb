Rails.application.routes.draw do
  namespace :admin_api do
    mount_devise_token_auth_for "Admin", at: "admin_auth",
      skip: [:invitations],
      controllers: {sessions: "admin_api/sessions"}

    resources :creators
  end

  namespace :creator_api do
    mount_devise_token_auth_for "Creator", at: "creator_auth",
      skip: [:invitations],
      controllers: {sessions: "creator_api/sessions"}
  end

  namespace :supports do
    resources :cities, only: :index
    resources :districts, only: :index
    resources :wards, only: :index

    resource :master_datas, only: :show
  end
end
