Rails.application.routes.draw do
  resources :users, except: [:edit, :update, :destroy]
  resource :session
end
