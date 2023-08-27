class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.page(params[:page]).order('id DESC').per(15)
    @category = Category.find_by(params[:id])
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(current_user)
      flash[:success] = "更新しました"
    else
      render :edit
    end
  end

  def quit
    @user = current_user
  end
  
  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end
  
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:recipe_id)
    @favorite_recipes = Recipe.find(favorites)
    @favorite_recipes = Kaminari.paginate_array(@favorite_recipes).page(params[:page]).per(15)
  end
  
  private 
  def user_params
    params.require(:user).permit(:name, :email, :user_icon)
  end
  
end
