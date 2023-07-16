Rails.application.routes.draw do
  
  #トップページ
  root to: 'public/homes#top'
  
  #カテゴリー
  namespace :admin do
    resources :categories, except: [:new, :show]
  end
  
  scope module: :public do
    #ユーザー
    get   'users/my_page'           => 'users#show', as: 'my_page'
    get   'users/information/edit'  => 'users#edit'
    patch 'users/information'       => 'users#update'
    get   'users/quit'              => 'users#quit'
    patch 'users/withdraw'          => 'users#withdraw'

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
