class Admin::RecipesController < ApplicationController
  def index
    @recipes = Recipe.page(params[:page]).order('id DESC').per(15)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_tags = @recipe.tags
    @comments = @recipe.comments
    @user = User.find_by(params[:id])
  end
  
  def destroy
    @racipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to admin_recipes_path
  end
  
end
