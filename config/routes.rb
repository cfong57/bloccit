Bloccit::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :topics do
    resources :posts, except: [:index] do
      resources :comments
      match '/up-vote', to: 'votes#up_vote', as: :up_vote
      match '/down-vote', to: 'votes#down_vote', as: :down_vote
      resources :favorites, only: [:create, :destroy]
    end
  end
  
  #controller: 'topics/posts'  <- don't need this until later

  match "about" => 'welcome#about', via: :get
  match "test" => 'welcome#test', via: :get

  root :to => 'welcome#index'
end