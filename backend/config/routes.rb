Rails.application.routes.draw do
  Healthcheck.routes(self)
  ActiveAdmin.routes(self)
  match 'admin/login' => 'adminsessions#new', :as => :new_admin_user_session, :via => :get
  match 'admin/login_google' => 'adminsessions#create', :as => :create_admin_user_session, :via => :get
  match 'admin' => 'adminsessions#destroy', :as => :destroy_admin_user_session, :via => :delete
  
  resources :room_messages
  resources :rooms
  resources :users, only: [:new, :create, :uploadphoto]
  resource :invitation

  root 'rails/welcome#index'
  get 'welcome', to: 'sessions#welcome'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'authorized', to: 'sessions#page_requires_login'
  post 'sendmessage', to: 'room_messages#new_message'
  post 'change_email', to: 'users#set_email'
  post 'uploadphoto', to: "users#uploadphoto"
  get 'getroommessagesonpdf', to: 'rooms#getroommessagespdf'
  post 'privaterooms', to: 'rooms#private'
  get 'userdata', to: 'users#getdata'
end
