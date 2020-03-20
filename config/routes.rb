Rails.application.routes.draw do
  mount_devise_token_auth_for "Admin", at: "admin_api/admin_auth", class_name: "Admin",
    skip: [:invitations],
    controllers: {sessions: "admin_api/sessions"}

  namespace :admin_api do
    resources :creators
  end

  mount_devise_token_auth_for "Creator", at: "creator_api/creator_auth",
    skip: [:invitations],
    controllers: {sessions: "creator_api/sessions"}

  namespace :creator_api do
    resources :products
  end

  namespace :supports do
    resources :cities, only: :index
    resources :districts, only: :index
    resources :wards, only: :index

    resource :master_datas, only: :show
  end
end
