Rails.application.routes.draw do
  root to: 'comprehends#index'
  resources :comprehends
end
