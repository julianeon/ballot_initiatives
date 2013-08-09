BallotInitiatives::Application.routes.draw do
  resources :initiatives
  resources :users

  root 'initiatives#index'
end
