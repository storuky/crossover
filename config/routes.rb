Rails.application.routes.draw do
  devise_for :users
  mount ActionCable.server => '/cable'

  root to: "public/home#index"

  get "sign/:type" => "auth#sign", as: :sign

  post "sign_in" => "auth#login"
  post "sign_up" => "auth#register"
  
  namespace :public, path: "" do
    get 'search' => 'search#index', ui_params: [:query, :page], as: :search, is_array: true

    resources :users do
      post "avatar", on: :collection
    end

    resources :requests, ui_params: [:status, :page] do
      resources :messages, controller: "request/messages"
    end
  end

  namespace :admin do

  end
end
