BallotInitiatives::Application.routes.draw do
	resources :initiatives
	resources :users
	resources :sessions, only: [:new, :create, :destroy]

	# Root path
	root 'initiatives#index'

	# Signup, sign-in and sign-out paths
	get '/signup',  to: 'users#new'
	get '/signin',  to: 'sessions#new'
	get '/signout', to: 'sessions#destroy', via: :delete
end
