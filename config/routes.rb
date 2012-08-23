Addressbook::Application.routes.draw do
  resources :sessions
  resources :users
  resources :contacts
  root :to => 'address_book#index'
end
