Addressbook::Application.routes.draw do
  resources :users
  resources :contacts
  root :to => 'address_book#index'
end
