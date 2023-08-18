class Admin::RecipesController < ApplicationController
  def index
    @recipes = Recipe.page(params[:page]).order('id DESC').per(15)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_tags = @recipe.tags
    @comments = @recipe.comments
    @user = User.find_by(params[:id])
    @category = Category.find_by(params[:category_id])
  end
  
  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:danger] = "投稿を削除しました"
      redirect_to admin_recipes_path
    end
  end
  
  def search_category
    @category = Category.find(params[:category_id])
    @category_recipes = @category.recipes.page(params[:page]).order('id DESC').per(15)
  end
  
  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @tag_recipes = @tag.recipes.page(params[:page]).order('id DESC').per(15)
  end
  
  
  
end
