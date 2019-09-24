Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#top'

  get 'users/:id' => 'users#posts', :as => :user_posts
  get 'home/about' => 'users#about', :as => :user_about

  resources :books
  resources :users, only: [:index, :show, :edit, :update, :about]
end
