Rails.application.routes.draw do
  root 'articles#index'
  get '/mypage', to: 'mypage#index'
  # , as: 'users_article'


  get '/articles/search', to: 'articles#search', as: 'search_article'
  resources :articles, only: [:index]

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'

  end


  # get '/mypage/_search', to: 'mypage#search', as: '_search_mypage'
  # resources :mypage, only: [:index]

  # get 'article/index'
  resources :articles
  resources :mypage, only: [:index]
  # devise_scope :user do
  #   get '/users/sign_out' => 'devise/sessions#destroy'

  # end

  # resources :mypage, only: [:index]
  # get '/mypage', to: 'mypage#index', as: 'users_article'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
