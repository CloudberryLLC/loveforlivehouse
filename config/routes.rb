Rails.application.routes.draw do

	root to: 'home#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
	mount Resque::Server, :at => '/showresquedashboard_d0g904jrdfjEH45r09SDKfhkjgt3y9gERUjhf65gdYhfdyjh5l3hEjSfu49edjkshRDhgd46lE3H5YEtr4dMDsetL'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :user do
      resources :performer_profiles, only: [:new, :edit]
  end

  resource :two_factor_auth, only: [:new, :create, :destroy]
  resource :tutorials, only: [:show]
  resources :dashboard, only: [:show]
  resources :profiles, only:[:show, :edit, :update, :destroy]
  resources :musicians, only: [:index, :show] #ゆくゆく個々のミュージシャンをSNSで繋げられるようにする
  resources :performer_profiles, only: [:edit, :update, :destroy]
	resources :donations, only: [:new, :create, :index, :show, :update]
  resources :contacts, only:[:index, :show, :new]
  resources :chat_messages, only:[:new]
	resources :offers
	resources :payments
  resources :reviews, only: [:new, :create]
  resources :cancelled_offers
  resources :favorites, only: [:index]
  resources :helps
  resources :screenshots
  resources :inquiries, only:[:new, :create, :show, :index]

	get '/for_musicians', to: 'abouts#for_musicians', as: 'for_musicians'
  get '/how_to_use', to: 'how_to_uses#show', as: 'how_to_use'
	get '/terms_of_services', to:'terms_of_services#show', as: 'terms_of_services'
  get '/privacy_policy', to: 'privacy_policies#show', as: 'privacy_policy'
  get '/tokushouhou', to: 'tokushouhous#show', as: 'tokushouhou'
  get '/user/:id/mygroups', to: 'performer_profiles#index', as: 'mygroups'
  get '/offers/:id/invoice', to: 'invoices#show', as:'invoice'
  get '/offers/:id/reciept', to: 'reciepts#show', as:'reciept'
	get '/livehouse/:id', to:'performer_profiles#show', as: 'performer'
  get '/performer_profiles/admincheck/:id', to: 'performer_profiles#admin_check', as: 'admin_check'
  get '/profiles/admincheck/:id', to: 'profiles#admin_check', as: 'admin_check_user'
  get '/payments/:id/confirmation', to:'payments#confirmation', as:'payment_confirmation'
  get '/payments/admincheck/:id', to: 'payments#admin_check', as: 'admin_check_payment'
  get '/cancelled_offers/admincheck/:id', to: 'cancelled_offers#admin_payback', as: 'admin_payback'
  get '/name_card_orders/:id/order_confirmation', to: 'name_card_orders#order_confirmation', as: 'name_card_order_confirmation'
	get '/search/help', to: 'helps#search', as: 'help_search'
  get '/search/performer', to: 'searchs#index', as: 'performer_search'

  post '/user/:id/performer_profiles/new' => 'performer_profiles#create'
	post '/contacts/:id' => 'contacts#post', as: 'chat_messages'
  post '/payments/:id/confirmation', to: 'payments#confirmed', as:'payment_confirmed'
  post '/name_card_orders/:id/order_confirmation', to: 'name_card_orders#order_confirmed', as: 'name_card_order_confirmed'
  post '/favorites/clip', to: 'favorites#clip', as:'clip_favorite'

  patch '/user/:id/performer_profiles/new' => 'performer_profiles#create'
  patch '/performer_profiles/admincheck/:id', to: 'performer_profiles#admin_approval', as: 'admin_approval'
  patch '/profiles/admincheck/:id', to: 'profiles#admin_approval', as: 'user_approval'
  patch '/cancelled_offers/:id/edit', to: 'offers#cancel', as: 'cancel'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

#余分なルーティングの削除
