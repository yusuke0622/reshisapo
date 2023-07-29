class Admin::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.all
  end

  def index
    @users = User.page(params[:page]).order('id ASC').per(12)
  end
end