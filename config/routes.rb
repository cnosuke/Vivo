Rails.application.routes.draw do
  root 'pages#index'

  get "/auth/:provider/callback" => "sessions#create"
  get "/signout" => "sessions#destroy", :as => :signout

  resources :notes
end
