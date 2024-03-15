Rails.application.routes.draw do
  resources :alerts
  resources :products
  resources :stores

  root 'inventory#home'
  get 'inventory/live_updates' => 'inventory#live_updates'
end