Rails.application.routes.draw do
  authenticate :person, -> person { person.email == ENV['ADMIN_EMAIL'] } do
    mount_avo at: '/avo'
  end

  root "main_page#index"
  
  get "event_list" => "main_page#event_list"
  get "map" => "main_page#map"
  
  devise_for :people
  devise_for :organizations
  
  resources :organizations, except: [:new, :create] do
    resources :events
    resource :accreditation, only: :show
  end

  resources :people, except: [:new, :create] do
    resources :notifications, only: [:index, :destroy]
  end
  resources :friendships, only: [:create, :destroy]
  resources :participants, only: [:create, :update, :destroy]
  resource :starred_organizations, only: [:create, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
