Rails.application.routes.draw do
  devise_for :users

  root 'items#index'
  resources :items do
    resources :purchases
  end

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  get '/items/:item_id/purchase', to: redirect('/')
  
end
