class Admin::UsersController < ApplicationController
  
  
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.all
  end

  def index
    @users = User.page(params[:page]).order('id ASC').per(12)
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:danger] = "ユーザーを削除しました"
      redirect_to admin_users_path
    end
  end
  
  private
 
end
