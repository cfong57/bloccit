Bloccit::Application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :topics do
    resources :posts, except: [:index] do
      resources :comments
    end
  end
  #only: [:create]

  match "about" => 'welcome#about', via: :get
  match "test" => 'welcome#test', via: :get

  root :to => 'welcome#index'
end