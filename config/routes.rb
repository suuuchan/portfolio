Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root to: "homes#top"
  get "/about" => "homes#about"
  # patch "/users" => "users#withdraw"
  # get "/posts" => "posts#index"
  # post "/posts" => "posts#create"
  delete "/posts" => "posts#destroy_all"
  # delete "/diaries" => "diaries#destroy_all"


  resources :diaries do
    collection do
      delete "destroy_all"
    end
  end
  
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    member do
      get "unsubscribe"
    end
    resource :relationships, only: [:create, :destroy]
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
  end

  resources :posts do
    # collection do
    #   delete "destroy_all"
    # end
    resources :comments, only: [:create, :destroy]
  end
  
  delete "/posts/:id/favorite" => "favorites#destroy", as: 'destroy_favorite'
  post "/posts/:id/favorite" => "favorites#create", as: 'create_favorite'

end
