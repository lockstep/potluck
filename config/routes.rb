Rails.application.routes.draw do
  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  resources :potlucks, only: [:index, :show]

  root 'home#index'

  devise_for :users, :controllers => {:registrations => "users/registrations"}

end
