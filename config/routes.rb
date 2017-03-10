Rails.application.routes.draw do
  root to: "public/requests#index"
  
  devise_for :users

  namespace :public, path: "" do
    resources :users, only: [:show, :edit, :destroy, :update]
    resources :requests, ui_params: [:status]
  end

  namespace :admin do

  end
end
