Rails.application.routes.draw do
  namespace :admin do
    mount_devise_token_auth_for "Admin", at: "admin_auth",
      skip: [:invitations],
      controllers: {sessions: "admin/sessions"}

    namespace :support do
      resources :cities, only: :index
      resources :districts, only: :index
      resources :wards, only: :index

      resource :master_datas, only: :show
    end
  end
end
