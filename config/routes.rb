Rails.application.routes.draw do

  devise_for :users
  root 'static_pages#top'

  resources :articles

  

end
