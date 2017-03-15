Rails.application.routes.draw do
  devise_for :users
  mount ActionCable.server => '/cable'

  root to: "public/home#index"

  get "sign/:type" => "auth#sign", as: :sign

  post "login" => "auth#login"
  post "register" => "auth#register"
  delete "logout" => "auth#logout"
  
  namespace :public, path: "" do
    get 'search' => 'search#index', ui_params: [:query], as: :search, is_array: true

    resources :users do
      post "avatar", on: :collection
    end

    resources :requests, ui_params: [:status] do
      resources :messages, controller: "request/messages"
    end
  end

  namespace :admin do
    get "/" => "home#index"

    resources :requests do
      resources :messages, controller: "request/messages"

      member do
        put :open
        put :close
      end
    end
    resources :users do
      member do
        put :block
        put :unblock
        post :avatar
      end
    end
  end
end
