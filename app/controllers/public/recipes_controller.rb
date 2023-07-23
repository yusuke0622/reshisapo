class Public::RecipesController < ApplicationController
  def index
    @recipes = Recipe.page(params[:page]).order('id DESC').per(15)
  end
  
  def show
    @recipe = Recipe.find(params[:id])
    @recipe_tags = @recipe.tags
  end

  def new
    @recipe = Recipe.new
    @ingredients = @recipe.ingredients.build
    @steps = @recipe.steps.build
  end
  
  def create
    @recipe = current_user.recipes.new(recipe_params)
    tag_list = params[:recipe][:tag_ids].split(nil)
    if @recipe.save
      @recipe.save_tag(tag_list)
      redirect_to recipe_path(@recipe.id)
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @tag_list = @recipe.tags.pluck(:tag_name).join(nil)
  end
  
  def update
    recipe = Recipe.find(params[:id])
    if recipe.update(recipe_params)
      flash[:success] = "投稿内容を変更しました"
      redirect_to recipe_path(recipe.id)
    else 
      render :edit
    end
  end
  
  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:success] = "投稿を削除しました"
      redirect_to user_path(current_user)
    end
  end
  
  private
    def recipe_params
      params.require(:recipe).permit(:user_id, :recipe_name, :introduction, :serving, :category_id, :recipe_image, :step_image,
      ingredients_attributes:[:id, :recipe_id, :ingredient_name, :quantity, :_destroy],
      steps_attributes:[:id, :recipe_id, :explanation, :step_image, :number, :_destroy])
    end
end
