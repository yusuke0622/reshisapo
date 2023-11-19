Rails.application.routes.draw do
  #管理者
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  #ユーザー
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  #管理者
  get 'admin' => 'admin/homes#top'
  namespace :admin do
    resources :users, only: [:show, :index, :destroy]
    patch 'withdraw/:id' => 'users#withdraw', as: "withdraw"
    resources :recipes, only: [:show, :index, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :categories, except: [:new, :show] do 
       get 'recipes' => 'recipes#search_category'
    end
    resources :tags do 
       get 'recipes' => 'recipes#search_tag'
    end
    get "search" => "admin/searches#search"
  end
  
  #ユーザー
  scope module: :public do
    root 'homes#top'
    get 'category_detail' => 'homes#category_detail'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/quit' => 'users#quit'
    patch 'users/withdraw' => 'users#withdraw'
    resources :users, only: [:index, :show] do 
      get :favorites, on: :member
    end
    resources :recipes do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :edit, :update, :destroy]
    end
    #タグ絞り込み
    resources :tags do
      get 'recipes' => 'recipes#search_tag'
    end
    #カテゴリー絞り込み
    resources :categories do
      get 'recipes' => 'recipes#search_category'
    end
    #通知
    resources :notifications, only: [:index]
    delete 'notifications/destroy_all' => 'notifications#destroy_all'
    #検索
    get "search" => "searches#search"
  end
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
