BallotInitiatives::Application.routes.draw do
	resources :users
	resources :initiatives
	resources :sessions, only: [:new, :create, :destroy]

	# Root path
	root 'initiatives#index'

	# Signup, sign-in and sign-out paths
	get    '/signup',  to: 'users#new'
	get    '/signin',  to: 'sessions#new'
	delete '/signout', to: 'sessions#destroy'
end
