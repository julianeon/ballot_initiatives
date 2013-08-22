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

	# Give/Revoke admin permissions paths
	get 'make_admin',   to: 'users#make_admin'
	get 'revoke_admin', to: 'users#revoke_admin'
end
