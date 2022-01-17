Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'


  # get 'article/index'
  resources :sample_articles
  resources :articles
  resources :mypage
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'

  end
  resources :mypage, only: [:index]
  get '/mypage', to: 'mypage#index', as: 'users_article'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
