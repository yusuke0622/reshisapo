Rails.application.routes.draw do
  
 
  
  #トップページ
  get 'admin' => 'admin/homes#top'
  root to: 'public/homes#top'
  
  get 'category_detail' => 'public/homes#category_detail'
  #カテゴリー
  namespace :admin do
    resources :categories, except: [:new, :show]
  end
  
  scope module: :public do
    #ユーザー
    get   'users/information/edit'  => 'users#edit'
    patch 'users/information'       => 'users#update'
    get   'users/quit'              => 'users#quit'
    patch 'users/withdraw'          => 'users#withdraw'
    resources :users, only:[:index, :show]
    resources :recipes

  end
  
  #管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  #ユーザー用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
