Addressbook::Application.routes.draw do
  resources :contacts
  root :to => 'address_book#index'
end
