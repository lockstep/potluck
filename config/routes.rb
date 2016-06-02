Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :organizations
    root to: "users#index"
  end

  root 'home#index'

  devise_for :users, :controllers => {:registrations => "users/registrations"}

end
