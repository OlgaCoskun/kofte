Rails.application.routes.draw do

  # дергаем спец. девайзовский метод, который генерит все нужные ему пути
  devise_for :users

  root "events#index"

  resources :events do
    # вложенный ресурс комментов
    resources :comments, only: [:create, :destroy]

    # вложенный ресурс подписок (см. rake routes)
    resources :subscriptions, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update]
end
