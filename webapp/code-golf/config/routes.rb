CodeGolf::Application.routes.draw do
  root 'leaderboard#show'
  resource :leaderboard
  resources :holes
  resources :teams
end
