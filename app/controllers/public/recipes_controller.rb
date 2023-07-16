class Public::RecipesController < ApplicationController
  def index
    @tag_list = Tag.all
    @recipes = Recipe.all
  end
  
  def show
    @recipe = Recipe.find(params[:id])
    @recipe_tags = @recipe.tags
  end

  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = current_user.recipes.new(recipe_params)
    tag_list = params[:recipe][:tag_name].split(nil)
    if @recipe.save
      @recipe.save_tag(tag_list)
      redirect_to recipes_path
    end
  end

  def edit
  end
  
  private
    def recipe_params
      params.require(:recipe).permit(:recipe_name, :introduction, :category_id)
    end
end
