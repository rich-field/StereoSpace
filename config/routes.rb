Rails.application.routes.draw do
  root :to => 'pages#index'
  resources :songs
  resources :tracks
end

