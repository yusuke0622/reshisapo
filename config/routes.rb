Rails.application.routes.draw do
  
  ##サインアップ・サインイン
  #管理者
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  #ユーザー
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  ##トップページ
  #管理者
  get 'admin' => 'admin/homes#top'
  root to: 'homes#top'
  
  get 'category_detail' => 'public/homes#category_detail'
  
  ##管理者ページ
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
  end
  
  ##ユーザー用ページ
 
  scope module: :public do
    get   'users/information/edit'  => 'users#edit'
    patch 'users/information'       => 'users#update'
    get   'users/quit'              => 'users#quit'
    patch 'users/withdraw'          => 'users#withdraw'
    resources :users, only: [:index, :show] do 
      member do 
        get :favorites　　
      end
    end
    resources :recipes do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :edit, :update, :destroy]
    end
    resources :tags do
      get 'recipes' => 'recipes#search_tag'
    end
    resources :categories do
      get 'recipes' => 'recipes#search_category'
    end
    resources :notifications, only: [:index]
    delete 'notifications/destroy_all' => 'notifications#destroy_all'
  end
  
  #検索
  get "admin/search" => "admin/searches#search"
  get "search" => "public/searches#search"
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
