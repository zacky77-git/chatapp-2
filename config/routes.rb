Rails.application.routes.draw do
  devise_for :users
  root to: 'rooms#index'
  resources :users, only: %i[edit update]
  resources :friends, only: %i[index create]
  get 'rooms/friend'
  post 'rooms/chat'
  resources :rooms, only: %i[index new create destroy] do
    # メッセージ送信機能に必要なindexとcreateのルーティングを記述 ネストでチャットルームに属しているメッセージという意味に
    resources :messages, only: %i[index create]
  end
end
