Rails.application.routes.draw do
  root 'sales#index'

  resources :sales
  post 'sales/file_import'
  devise_for :users
end
