Rails.application.routes.draw do

	root to: 'home#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
	mount Resque::Server, :at => '/showresquedashboard_d0g904jrdfjEH45r09SDKfhkjgt3y9gERUjhf65gdYhfdyjh5l3hEjSfu49edjkshRDhgd46lE3H5YEtr4dMDsetL'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :user do
      resources :livehouses, only: [:new, :edit]
  end

  resource :two_factor_auth, only: [:new, :create, :destroy]
  resource :tutorials, only: [:show]
  resources :dashboard, only: [:show]
  resources :profiles, only:[:show, :edit, :update, :destroy]
  resources :livehouses, only: [:show, :edit, :update, :destroy]
	resources :donations, only: [:new, :create, :edit, :update, :index, :show]
  resources :contacts, only:[:index, :show, :new]
  resources :chat_messages, only:[:new]
  resources :favorites, only: [:index]
  resources :helps
  resources :screenshots
  resources :inquiries, only:[:new, :create, :show, :index]

	get '/for_musicians', to: 'abouts#for_musicians', as: 'for_musicians'
  get '/how_to_use', to: 'how_to_uses#show', as: 'how_to_use'
	get '/terms_of_services', to:'terms_of_services#show', as: 'terms_of_services'
  get '/privacy_policy', to: 'privacy_policies#show', as: 'privacy_policy'
  get '/tokushouhou', to: 'tokushouhous#show', as: 'tokushouhou'
  get '/user/:id/mygroups', to: 'livehouses#index', as: 'mygroups'
  get '/livehouses/admincheck/:id', to: 'livehouses#admin_check', as: 'admin_check'
  get '/profiles/admincheck/:id', to: 'profiles#admin_check', as: 'admin_check_user'
	get '/search/help', to: 'helps#search', as: 'help_search'
  get '/search/livehouse', to: 'searchs#index', as: 'livehouse_search'
	get '/stripe/connect/oauth/', to: 'profiles#stripe_connect_oauth', as:'stripe_connect'
	get '/donations/confirmation/:id', to: 'donations#confirmation', as: 'donation_confirmation'
	get '/donations/:id/payment_succeeded', to: 'donations#payment_succeeded', as: 'donation_payment_succeeded'

#	post '/donations/confirmation', to: 'donations#confirmation', as: 'donation_confirmation'
  post '/user/:id/livehouses/new' => 'livehouses#create'
	post '/contacts/:id' => 'contacts#post', as: 'chat_messages'
  post '/payments/:id/confirmation', to: 'payments#confirmed', as:'payment_confirmed'
  post '/favorites/clip', to: 'favorites#clip', as:'clip_favorite'
	post '/stripe/webhook', to: 'donations#stripe_webhook', as:'stripe_webhook'

  patch '/user/:id/livehouses/new' => 'livehouses#create'
  patch '/livehouses/admincheck/:id', to: 'livehouses#admin_approval', as: 'admin_approval'
  patch '/profiles/admincheck/:id', to: 'profiles#admin_approval', as: 'user_approval'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
