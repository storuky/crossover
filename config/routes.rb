Rails.application.routes.draw do
  root to: "public/home#index"
  
  devise_for :users

  namespace :public, path: "" do
    
  end

  namespace :admin do

  end
end
