Rails.application.routes.draw do
  root 'home#index'
  get '/users/:address/nonce', to: 'users#nonce'

  post '/sessions', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy', as: :destroy_user_session

  get '/wallet/nfts', to: 'wallet#nfts', as: :wallet_nfts

  get '/vault/nfts', to: 'vault#nfts', as: :vault_nfts
end
