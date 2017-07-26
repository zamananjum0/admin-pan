Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboards#index'
  
  resources :user_sessions do
    collection do
      get 'sign_in'
    end
  end
  resources :dashboards
  resources :users, only: [:index] do
    member do
      get 'user_events'
      get 'user_posts'
      get 'user_followers'
    end
  end
  resources :posts, only:[:index]
  resources :events, only:[:index, :show] do
    resources :posts, only:[:destroy] do
      member do
        get 'get_likes'
        get 'get_comments'
        delete 'undo'
      end
      resources :post_comments, only: [:destroy]
    end
  end
  
  resources :categories
  
end
