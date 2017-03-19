Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root to: "public/home#index"

  get "sign/:type" => "auth#sign", as: :sign

  post "login" => "auth#login"
  post "register" => "auth#register"
  delete "logout" => "auth#logout"
  
  namespace :public, path: "" do
    get 'search' => 'search#index', ui_params: [:query], as: :search, is_array: true

    resources :users do
      collection do
        post "avatar"
        get :edit
        put :update
        delete :destroy
      end

    end

    resources :requests, ui_params: [:status] do
      resources :messages, controller: "request/messages"
    end
  end

  namespace :admin do
    get "/" => "home#index"

    namespace :request do
      resources :categories
    end

    resources :requests do
      shallow do
      end
      resources :messages, controller: "request/messages"

      member do
        put :open
        put :close
        put :read
      end

      collection do
        get :unreaded_count
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
  
  devise_for :users

end

