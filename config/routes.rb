Rails.application.routes.draw do
  
  ##　サインアップ・サインイン
  #管理者
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  #ユーザー
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  ## トップページ
  # 管理者
  get 'admin' => 'admin/homes#top'
  # ユーザー
  root to: 'public/homes#top'
  
  ## 管理者ページ
  namespace :admin do
    #ユーザー
    resources :users, only: [:show, :index, :destroy]
    patch 'withdraw/:id' => 'users#withdraw', as: "withdraw"
    #レシピ
    resources :recipes, only: [:show, :index, :destroy] do
      resources :comments, only: [:destroy]
    end
    #カテゴリー・カテゴリー検索
    resources :categories, except: [:new, :show] do 
       get 'recipes' => 'recipes#search_category'
    end
    #タグ・タグ検索
    resources :tags do 
       get 'recipes' => 'recipes#search_tag'
    end
  end
  
  ##　ユーザー用ページ
  # カテゴリー詳しく
  get 'category_detail' => 'public/homes#category_detail'
  
  scope module: :public do
    # ユーザー
    get   'users/information/edit'  => 'users#edit'
    patch 'users/information'       => 'users#update'
    get   'users/quit'              => 'users#quit'
    patch 'users/withdraw'          => 'users#withdraw'
    resources :users, only:[:index, :show] do 
      # お気に入りレシピ一覧
      member do 
        get :favorites　　
      end
    end
    # レシピ
    resources :recipes do
      # お気に入り登録・解除
      resource :favorites, only: [:create, :destroy]
      # コメント
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
    # 通知
    resources :notifications, only: [:index]
    delete 'notifications/destroy_all' => 'notifications#destroy_all'
  end
  
  #検索
  get "admin/search" => "admin/searches#search"
  get "search" => "public/searches#search"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
