class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.page(params[:page]).order('id DESC').per(15)
  end

  def index
    @users = User.page(params[:page]).order('id ASC').per(12)
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:error] = "ユーザーを削除しました"
      redirect_to admin_users_path
    end
  end
  
  private
 
end
